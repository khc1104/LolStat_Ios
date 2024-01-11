//
//  SummonerInfoPage.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/18/23.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct SummonerInfoPage: View{
    let store : StoreOf<UserStore>
    let profile: Profile
    let matches: [SimpleMatch]
    
    var body: some View{
        WithViewStore(self.store, observe: {$0}){ viewStore in
            ScrollView(showsIndicators: false){
                SummonerInfo(profile: profile)
                    .padding()
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        RecentlyKdaCard(KDA: viewStore.recentlyKDA)
                        if let mostChampion = viewStore.mostChampion{
                            MostChampionList(mostChampions: mostChampion)
                        }
                    }
                }
                LazyVStack(){
                    ForEach(matches){match in
                        MatchInfo(match: match)
                            .onTapGesture {
                                viewStore.send(.matchInfoTapped(matchId: match.matchId))
                            }
                            .fullScreenCover(isPresented: viewStore.$enableSheet) {
                                MatchDetail(store: store)
                                    
                            }
                    }
                    if viewStore.moreMatchIsLoading {
                        ProgressView()
                    }else{
                        Rectangle()
                            .background(.clear)
                            .onAppear{
                                viewStore.send(.matchMoreAppear)
                            }
                    }
                    
                    
                     
                }
            }
        }
    }
}

