//
//  RankingStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/11/23.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct RankingStore: Reducer{
    struct State : Equatable{
        var soloLeaderBoard : LeaderBoard?
        var flexLeaderBoard : LeaderBoard?
        var isLoading : Bool = true
        var page : Int32 = 1
        var queueType: LolStatAPIClient.QueueType = .RANKED_SOLO
        
        var path = StackState<UserStore.State>()
    }
    
    enum Action{
        case requestLeaderBoard
        case responseLeaderBoard(LeaderBoard?)
        case tappedQueueType
        case path(StackAction<UserStore.State, UserStore.Action>)
        
    }
    @Dependency(\.lolStatAPIClient)var lolStatAPI
    var body: some ReducerOf<Self>{
        Reduce { state, action in
            switch action{
                //리더보드 요청
            case .requestLeaderBoard :
                state.isLoading = true
                return .run { [page = state.page, queue = state.queueType] send in
                    let leaderBoard = try await lolStatAPI.requestLeaderBoardAPI(page: page, queue: queue)
                    await send(.responseLeaderBoard(leaderBoard))
                    
                }
                //리더보드 리스폰스
            case let .responseLeaderBoard(leaderBoard):
                switch state.queueType{
                case .RANKED_SOLO:
                    state.soloLeaderBoard = leaderBoard
                case .RANKED_FLEX:
                    state.flexLeaderBoard = leaderBoard
                }
                state.isLoading = false
                return .none
                
                //큐타입 탭했을 때
            case .tappedQueueType:
                switch state.queueType{
                case .RANKED_SOLO:
                    state.queueType = .RANKED_FLEX
                case .RANKED_FLEX:
                    state.queueType = .RANKED_SOLO
                }
                
                return .run{send in await send(.requestLeaderBoard)
                }
            case .path:
                return .none
            }
        }
    }
}
