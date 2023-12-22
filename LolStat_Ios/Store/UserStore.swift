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
        var path = StackState<UserStore.State>()
    }
    
    /*
     액션
     */
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case searchUserInfo
        case searchButtonTapped
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
    func core(into state : inout State, action: Action) -> Effect<Action>{
        switch action{
            //바인딩 상태들에 관한 액션
        case .binding:
            return .none
            // 유저 정보 검색
        case .searchUserInfo:
            state.isLoading = true
            return .run { [summonerName = state.summonerName] send in
                let summonerInfo = try await lolStatAPI.requestSummonerInfoAPI(summonerName: summonerName)
                await send (.userInfoResponse(summonerInfo))
                await send (.getSummonerMatch(summonerInfo))
            }
             
            // 유저 정보 리스폰스 받음
        case let .userInfoResponse(summonerInfo):
            state.summonerInfo = summonerInfo
            state.isLoading = false
            return .none
            
        case .searchButtonTapped:
            return .none
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

