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
        var summonerInfo : Summoner?
        var searchedSummonerMatches: [SimpleMatch]?
        var isLoading = true
        @BindingState var enableSheet : Bool = false
        var matchDetail : SimpleMatch?
        
        var path = StackState<UserStore.State>()
    }
    
    /*
     액션
     */
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case searchUserInfo
        case matchInfoTapped(matchId: String)
        case dismissMatchDetail
        case userInfoResponse(Summoner?)
        case getSummonerMatch(Summoner?)
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
            // 유저 정보 검색
        case .searchUserInfo:
            state.isLoading = true
            let nameTag : String
            if state.summonerName.contains(/\#/){
                let splitName = state.summonerName.split(separator: "#")
                nameTag = splitName[0] + "-" + splitName[1]
            }else{
                nameTag = state.summonerName+"-KR1"
            }
            
            print(nameTag)
            return .run { /*[summonerName = state.summonerName]*/ send in
                let summonerInfo = try await lolStatAPI.requestSummonerInfoAPI(summonerName: nameTag)
                await send (.userInfoResponse(summonerInfo))
                await send (.getSummonerMatch(summonerInfo))
            }
             
            // 유저 정보 리스폰스 받음
        case let .userInfoResponse(summonerInfo):
            state.summonerInfo = summonerInfo
            state.isLoading = false
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
        case .dismissMatchDetail:
            state.enableSheet = !state.enableSheet
            
            return .none
            //return .run{_ in await self.dismiss()}
            
        case let .getSummonerMatch(summonerInfo):
            if let summoner = summonerInfo{
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
                
                state.searchedSummonerMatches = searchedMatches
            }else{
                print("participant ERROR")
            }
            return .none
        case .path:
            return .none
        }
    }
}

