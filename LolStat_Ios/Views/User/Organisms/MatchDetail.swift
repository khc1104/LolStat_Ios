//
//  MatchDetail.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/22/23.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct MatchDetail : View {
    let store : StoreOf<UserStore>

    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: UserStore.Action.path)){
            WithViewStore(self.store, observe: {$0}){ viewStore in
                VStack{
                    if let matchDetail = viewStore.matchDetail{
                        ForEach(0..<10){ i in
                            NavigationLink(state: UserStore.State(summonerName:
                                    "\(matchDetail.participants[i].summonerName)-KR1")){ //TODO 태그 적용
                                MatchDetailInfo(participant: matchDetail.participants[i])
                            }
                        }
                    }
                    else{
                        Text("matchDetail error")
                    }
                }
                .gesture(
                    DragGesture().onEnded({value in
                        if value.location.y - value.startLocation.y > 150{
                            viewStore.send(.dismissMatchDetail)
                        }
                    })
                )
            }
        } destination: { store in
            User(store: store)
        }
    }
}
