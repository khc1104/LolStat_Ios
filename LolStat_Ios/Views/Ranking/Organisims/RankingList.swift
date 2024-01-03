//
//  RankingList.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/29/23.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct RankingList: View {
    let store : StoreOf<RankingStore> = LolStat_IosApp.rankingStore
    
    var body: some View {
        NavigationStackStore(self.store.scope(state:\.path, action:RankingStore.Action.path)){
            WithViewStore(self.store, observe: {$0}){viewStore in
                if viewStore.isLoading == true{
                    ProgressView()
                        .onAppear{
                            viewStore.send(.requestLeaderBoard)
                        }
                }
                else if let leaderBoard = (viewStore.queueType == .RANKED_SOLO ? viewStore.soloLeaderBoard : viewStore.flexLeaderBoard){
                    ScrollView{
                        HStack(spacing: 0){
                            ZStack(alignment: .center){
                                Text("솔로랭크")
                            }
                            .frame(width: Const.Screen.WIDTH/2)
                            .background(viewStore.queueType == .RANKED_SOLO ? .mint : .white)
                            .onTapGesture {
                                if viewStore.queueType == .RANKED_FLEX{
                                    viewStore.send(.tappedQueueType)
                                }
                            }
                            ZStack(alignment: .center){
                                Text("자유랭크")
                            }
                            .frame(width: Const.Screen.WIDTH/2)
                            .background(viewStore.queueType == .RANKED_FLEX ? .mint : .white)
                            .onTapGesture {
                                if viewStore.queueType == .RANKED_SOLO{
                                    viewStore.send(.tappedQueueType)
                                }
                            }
                        }
                        RankingColumn()
                            .frame(maxWidth: Const.Screen.WIDTH)
                        ForEach(Array(leaderBoard.players.enumerated()), id: \.offset){i, summoner in
                            NavigationLink(state: UserStore.State(summonerName: summoner.summonerName)){
                                SummonerRank(rank: i, summoner:summoner)
                            }
                        }
                    }
                }else{
                    Text("정보를 불러오지 못했습니다.")
                }
            }
        } destination: { store in
            User(store: store)
        }
    }
}