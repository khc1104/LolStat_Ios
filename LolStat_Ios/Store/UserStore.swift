//
//  UserStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//

import Foundation
import ComposableArchitecture

struct UserStore : Reducer{
    
    /*
     상태
     */
    struct State : Equatable{
        @BindingState var summonerName : String = ""
        var summonerId : String = ""
        var summonerInfo : Summoner?
        var searchedSummonerMatches: [SimpleMatch]?
        var mostChampion : [MostChampion]?
        @BindingState var enableSheet : Bool = false
        var matchDetail : SimpleMatch?
        var recentlyKDA : [Int32]=[0,0,0]
        var matchPage : Int32 = 2
        var isLoading = true
        var moreMatchIsLoading = false
        
        var path = StackState<UserStore.State>()
    }
    
    /*
     액션
     */
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case requestUserInfoFromSummonerName
        case requestUserInfoFromSummonerId
        case responseUserInfo(Summoner?)
        case getSummonerMatch
        case requestMatches
        case responseMatches([SimpleMatch]?)
        case onAppear
        case matchInfoTapped(matchId: String)
        case matchMoreAppear
        case dismissMatchDetail
        
        case path(StackAction<UserStore.State, UserStore.Action>)
    }
    
    /*
     리듀서
     */
    //@Dependency (\.dismiss) var dismiss
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce(self.core)
            .forEach(\.path, action: /Action.path){
                UserStore()
            }
    }
    
    @Dependency(\.lolStatAPIClient) var lolStatAPI
    @Dependency(\.dismiss) var dismiss
    func core(into state : inout State, action: Action) -> Effect<Action>{
        switch action{
            //바인딩 상태들에 관한 액션
        case .binding:
            return .none
            // 유저 정보 검색- 소환사 이름으로 검색
            
        case .onAppear:
            state.isLoading = true
            if state.summonerName != ""{
                return .run{ send in
                    await send(.requestUserInfoFromSummonerName)
                }
            }else if state.summonerId != ""{
                return .run{ send in
                    await send(.requestUserInfoFromSummonerId)
                }
            }
            return .none
            
        case .requestUserInfoFromSummonerName:
            let nameTag : String
            if state.summonerName.contains(/\#/){
                let splitName = state.summonerName.split(separator: "#")
                nameTag = splitName[0] + "-" + splitName[1]
            }else{
                nameTag = state.summonerName+"-KR1"
            }
            
            return .run { send in
                let summonerInfo = try await lolStatAPI.requestSummonerInfoAPI(summonerName: nameTag)
                await send (.responseUserInfo(summonerInfo))
                //await send (.getSummonerMatch(summonerInfo))
            }
            //유저 정보 검색 - 소환사 Id로 검색
        case .requestUserInfoFromSummonerId:
            return .run { [summonerId = state.summonerId] send in
                let summonerInfo = try await lolStatAPI.requestSummonerInfoAPI(summonerId: summonerId)
                await send (.responseUserInfo(summonerInfo))
                
            }
            //매치 정보 검색
        case .requestMatches:
            return .run{ [page = state.matchPage, puuid = state.summonerInfo!.profile.puuid] send in
                let matches = try await lolStatAPI.requestMatchsAPI(puuid: puuid, page: page)
                
                await send(.responseMatches(matches))
            }
            
            // 유저 정보 리스폰스 받음
        case let .responseUserInfo(summonerInfo):
            state.summonerInfo = summonerInfo
            state.isLoading = false
            return .run{ send in
                await send (.getSummonerMatch)
            }
            //매치 정보 리스폰스 받음
        case let .responseMatches(matches):
            state.summonerInfo?.matches += matches!
            state.matchPage = state.matchPage+1
            return .run { send in
                await send(.getSummonerMatch)
            }
            //매치정보 눌렀을 때 - 매치 상세 정보가 올라와야함
        case let .matchInfoTapped( matchId):
            state.enableSheet = !state.enableSheet
            if let match = state.summonerInfo?.matches.first(where: {$0.matchId == matchId}){
                state.matchDetail = match
            }else{
                return .none
            }
            return .none
            //매치 리스트의 가장 아래부분을 보았을 때
        case .matchMoreAppear:
            state.moreMatchIsLoading = true
            return .run{send in
                await send(.requestMatches)
            }
            
        case .dismissMatchDetail:
            state.enableSheet = !state.enableSheet
            
            return .none
            //return .run{_ in await self.dismiss()}
            
            //매치 정보들 검색한 소환사 정보만 모아 놓기
        case .getSummonerMatch:
            if let summoner = state.summonerInfo{
                                let searchedMatches = summoner.matches.compactMap{match in
                    SimpleMatch(matchId: match.matchId,
                                gameMode: match.gameMode,
                                gameType: match.gameType,
                                queueId: match.queueId,
                                participants:
                                    match.participants.filter{
                        $0.summonerName == summoner.profile.summonerName
                    })
                    
                }
                
                //최근 전적 KDA 산출
                var KDA : [Int32] = [0,0,0]

                for match in searchedMatches {
                    KDA[0] += match.participants[0].kills
                    KDA[1] += match.participants[0].deaths
                    KDA[2] += match.participants[0].assists
                }
                KDA = KDA.map{
                    $0/Int32(searchedMatches.count)
                }
                state.searchedSummonerMatches = searchedMatches
                state.recentlyKDA = KDA
                
                
                //챔피언 사용 횟수
                
                var playedChampion : [Champion] = []
                for match in searchedMatches {
                    playedChampion.append(match.participants[0].champion)
                }
                var championCount = [Champion : Int]()
                playedChampion.forEach{
                    championCount[$0, default: 0] += 1
                }
                
                var orderedMostChampion = championCount.sorted{ $0.1 > $1.1}
                var mostChampion : [MostChampion] = []
                var order : Int = 1
                orderedMostChampion.forEach{ championCount in
                    mostChampion.append(MostChampion(champion: championCount.key,
                                            count: championCount.value,
                                            order: order))
                    order += 1
                }
                print("!!!!!!!")
                state.mostChampion = mostChampion
                state.moreMatchIsLoading = false
                
            }else{
                print("participant ERROR")
            }
            return .none
        case .path:
            return .none
        }
    }
}

