//
//  User.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/16.
//

import ComposableArchitecture
import SwiftUI


struct User : View{
    let store : StoreOf<UserStore>
    
    var body : some View{
        WithViewStore(self.store, observe: {$0}){ viewStore in
            if viewStore.isLoading{
                ProgressView()
                    .onAppear{
                        viewStore.send(.searchUserInfo)
                    }
            }
            else{
                if let summonerInfo = viewStore.summonerInfo, let matches = viewStore.searchedSummonerMatches
                {
                    SummonerInfoPage(store: store, profile: summonerInfo.profile,
                                     matches: matches)
                }else{
                    Text("존재하지 않는 소환사 입니다.")
                }
            }
        }
    }
    
}
/*
struct Preview_User: PreviewProvider{
    static var previews: some View{
        User(store: .init(
            initialState: .init(),
            reducer:{
                UserStore()
                    ._printChanges()
            }
            )
        )
    }
}
*/
