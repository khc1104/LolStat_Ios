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
            ScrollView{
                SummonerInfo(profile: profile)
                    .padding()
                RecentlyKDA(KDA: viewStore.recentlyKDA)
                VStack(){
                    ForEach(matches){match in
                        MatchInfo(match: match)
                            .onTapGesture {
                                viewStore.send(.matchInfoTapped(matchId: match.matchId))
                            }
                            .fullScreenCover(isPresented: viewStore.$enableSheet) {
                                MatchDetail(store: store)
                                    
                            }
                    }
                }
            }
        }
    }
}
