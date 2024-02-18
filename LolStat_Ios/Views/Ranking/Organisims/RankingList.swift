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
        WithViewStore(self.store, observe: {$0}){viewStore in
            NavigationStackStore(self.store.scope(state:\.path, action:RankingStore.Action.path)){
                if viewStore.isLoading == true{
                    ProgressView()
                        .onAppear{
                            if viewStore.soloLeaderBoard == nil || viewStore.flexLeaderBoard == nil{
                                viewStore.send(.requestLeaderBoard)
                            }
                        }
                }
                else if let leaderBoard = (viewStore.queueType == .RANKED_SOLO ? viewStore.soloLeaderBoard : viewStore.flexLeaderBoard){
                    ScrollView{
                        HStack(spacing: 0){
                            ZStack(alignment: .center){
                                Text("솔로랭크")
                                    .padding(.vertical)
                            }
                            .frame(width: Const.Screen.WIDTH/2)
                            .background(viewStore.queueType == .RANKED_SOLO ? .verifyBlue : .defaultBackground)
                            .onTapGesture {
                                if viewStore.queueType == .RANKED_FLEX{
                                    viewStore.send(.tappedQueueType)
                                }
                            }
                            ZStack(alignment: .center){
                                Text("자유랭크")
                                    .padding(.vertical)
                            }
                            .frame(width: Const.Screen.WIDTH/2)
                            .background(viewStore.queueType == .RANKED_FLEX ? .verifyBlue : .defaultBackground)
                            .onTapGesture {
                                if viewStore.queueType == .RANKED_SOLO{
                                    viewStore.send(.tappedQueueType)
                                }
                            }
                        }
                        
                        RankingColumn()
                            .frame(maxWidth: Const.Screen.WIDTH)
                        ForEach(Array(leaderBoard.players.enumerated()), id: \.offset){i, summoner in
                            NavigationLink(state: UserStore.State(summonerId: summoner.summonerId)){
                                SummonerRank(rank: i, summoner:summoner)
                            }
                        }
                    }
                }else{
                    Text("정보를 불러오지 못했습니다.")
                }
            }destination: { store in
                User(store: store)
                    .navigationBarBackButtonHidden(true)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("뒤로"){
                                viewStore.send(.backButtonTapped)
                            }
                        }
                    }
            }
            .foregroundStyle(.white)
            .background(.defaultBackground)
        }
    }
}
