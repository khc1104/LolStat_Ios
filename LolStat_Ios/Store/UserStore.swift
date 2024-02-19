//
//  UserStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//


import Foundation
import ComposableArchitecture

enum Cancel{
    case requestSummonerId
    case requestSummonerName
}

struct UserStore : Reducer{
    
    /*
     상태
     */
    struct State : Equatable{
        @BindingState var summonerName : String = ""
        var summonerId : String = ""
        var summonerInfo : Summoner?
        var searchedSummonerMatches: [SimpleMatch]?
        var searchedSummonerMatchesSolo : [SimpleMatch]?
        var searchedSummonerMatchesFlex : [SimpleMatch]?
        var mostChampion : [MostChampion]?
        @BindingState var isSearchTapped: Bool = false
        @BindingState var enableSheet : Bool = false
        var matchDetail : SimpleMatch?
        var recentlyKDA : [Int32]=[0,0,0]
        var matchPage : Int32 = 2
        var isLoading = true
        var isTimeOut = false
        var moreMatchIsLoading = false
        
        @BindingState var selectedMatch : QueueId = .ALL
        
        var savedSummoner = UserDefaults.standard.array(forKey: "savedSummoner") as? [String] ?? []
        
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
        case userPageOnAppear
        case userPageOnAppearTimeOut
        case backButtonTapped
        case matchInfoTapped(matchId: String)
        case matchMoreAppear
        case dismissMatchDetail
        case summonerInfoOnAppear
        case selectQueueIdOnChange
        
        case searchButtonTapped
        case savedSummonerTapped(summonerName : String)
        case clearButtonTapped
        
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
            //
            //API Request
            //
            // 유저 정보 검색- 소환사 이름으로 검색
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
            let queueId = state.selectedMatch.rawValue
            return .run{ [page = state.matchPage, puuid = state.summonerInfo!.profile.puuid, queueId = queueId] send in
                let matches = try await lolStatAPI.requestMatchsAPI(puuid: puuid, page: page, queueId: queueId)
                
                await send(.responseMatches(matches))
            }
            
            //
            //API Response
            //
            // 유저 정보 리스폰스 받음
        case let .responseUserInfo(summonerInfo):
            state.summonerInfo = summonerInfo
            state.isLoading = false
            return .run{ send in
                await send (.getSummonerMatch)
            }
            //매치 정보 리스폰스 받음
        case let .responseMatches(matches):
            if state.matchPage == 1{ //페이지가 1이면 큐타입 필터링 한것이므로 더하면 안되고 바꿔야함
                state.summonerInfo?.matches = matches!
            }else{
                state.summonerInfo?.matches += matches!
            }
            state.matchPage = state.matchPage+1
            return .run { send in
                await send(.getSummonerMatch)
            }
            
            //
            //유저페이지 이벤트
            //
            //유저페이지 onAppear
        case .userPageOnAppear:
            state.summonerInfo = nil
            state.isLoading = true
            if state.summonerName != ""{
                return .run{ send in
                    await send(.requestUserInfoFromSummonerName)
                }.cancellable(id: Cancel.requestSummonerName)
            }else if state.summonerId != ""{
                return .run{ send in
                    await send(.requestUserInfoFromSummonerId)
                }.cancellable(id: Cancel.requestSummonerId)
            }
            return .none
            //유저페이지에서 뒤로가기 버튼으로 메인페이지로 나갈 때
        case .backButtonTapped:
            state.summonerName = ""
            state.summonerId = ""
            state.summonerInfo = nil
            state.isSearchTapped = false
            return .none
            //유저페이지 타임아웃
        case .userPageOnAppearTimeOut:
            if state.summonerName != ""{
                return .cancel(id: Cancel.requestSummonerName)
            }else if state.summonerId != ""{
                return .cancel(id: Cancel.requestSummonerId)
            }
            state.isLoading = false
            state.isTimeOut = true
            return .none
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
            //매치 상세페이지 뒤로가기
        case .dismissMatchDetail:
            state.enableSheet = !state.enableSheet
            
            return .none
            //매치 큐타입필터링
        case .selectQueueIdOnChange:
            state.matchPage = 1
            state.searchedSummonerMatches = []
            return .none
            /*
            return .run{ send in
                await send(.requestMatches)
            }
             */
            
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
                struct championKDA {
                    var champion : Champion
                    var kills : Int = 0
                    var deaths : Int = 0
                    var assists : Int = 0
                    var wins : Int = 0
                    var count : Int = 1
                }
                var championKDAs : [championKDA] = []
                for match in searchedMatches{
                    if let i = championKDAs.firstIndex(where: {
                        $0.champion == match.participants[0].champion
                    }){
                        championKDAs[i].kills += Int(match.participants[0].kills)
                        championKDAs[i].deaths += Int(match.participants[0].deaths)
                        championKDAs[i].assists += Int(match.participants[0].assists)
                        championKDAs[i].count += 1
                        championKDAs[i].wins += match.participants[0].win ? 1 : 0
                    }else{
                        championKDAs.append(championKDA(
                            champion: match.participants[0].champion,
                            kills: Int(match.participants[0].kills),
                            deaths: Int(match.participants[0].deaths),
                            assists: Int(match.participants[0].assists),
                            wins : match.participants[0].win ? 1 : 0
                        ))
                    }
                }
                let digit : Float = pow(10, 2)
                var playedChampions : [MostChampion] = []
                for KDA in championKDAs{
                    let kills = Float(KDA.kills)
                    let assists = Float(KDA.assists)
                    let deaths = Float(KDA.deaths)
                    let wins = Float(KDA.wins)
                    let count = Float(KDA.count)
                    playedChampions.append(MostChampion(
                        champion: KDA.champion,
                        count: KDA.count,
                        kda:  round(((kills+assists)/deaths) * digit)/digit,
                        winrate: round((wins/count) * digit)
                    )
                    )
                }
                let orderedMostChampion = playedChampions.sorted{$0.count > $1.count}
                state.mostChampion = orderedMostChampion
                state.moreMatchIsLoading = false
                
                /*
                var playedChampion : [Champion] = []
                for match in searchedMatches {
                    playedChampion.append(match.participants[0].champion)
                }
                var championCount = [Champion : Int]()
                playedChampion.forEach{
                    championCount[$0, default: 0] += 1
                }
                
                let orderedMostChampion = championCount.sorted{ $0.1 > $1.1}
                var mostChampion : [MostChampion] = []
                var order : Int = 1
                orderedMostChampion.forEach{ championCount in
                    mostChampion.append(MostChampion(champion: championCount.key,
                                            count: championCount.value,
                                            order: order))
                    order += 1
                }
                //print("!!!!!!!")
                state.mostChampion = mostChampion
                state.moreMatchIsLoading = false
                */
            }else{
                print("participant ERROR")
            }
            return .none
            //소환사 정보가 나올 때 최근 검색 기록 등록
        case .summonerInfoOnAppear:
            if let summonerInfo = state.summonerInfo{
                let summonerNameTag = summonerInfo.profile.gameName+"#"+summonerInfo.profile.tagLine
                var savedSummoner = UserDefaults.standard.array(forKey: "savedSummoner") as? [String] ?? []
                
                
                if !savedSummoner.contains(summonerNameTag){ //저장되지 않은 소환사만
                    savedSummoner.append(summonerNameTag)
                }
                if savedSummoner.count >= 11{ //최대 10개 까지 저장
                    savedSummoner.removeFirst()
                }
                state.savedSummoner = savedSummoner
                UserDefaults.standard.set(savedSummoner, forKey: "savedSummoner")
            }
            return .none
            //
            //서치페이지 이벤트
            //
        case .searchButtonTapped: //onSubmit시 이벤트
            state.isSearchTapped = true
            return .none
        case let .savedSummonerTapped(summonerName): //검색했던 소환사 터치 이벤트
            state.summonerName = summonerName
            state.isSearchTapped = true
            return .none
        case .clearButtonTapped: //textfiled 비우는 버튼 이벤트
            state.summonerName = ""
            return .none
                case .path:
            return .none
        }
    }
}

