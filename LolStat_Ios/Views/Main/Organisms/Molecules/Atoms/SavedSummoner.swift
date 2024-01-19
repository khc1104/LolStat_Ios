//
//  savedSummoner.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/18/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct SavedSummoner : View {
    let store : StoreOf<UserStore>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            VStack{
                ForEach(viewStore.savedSummoner.reversed(), id:\.self){ summonerNameTag in
                    ZStack{
                        Text(summonerNameTag)
                    }
                    .frame(width: Const.Screen.WIDTH * 0.9, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .border(.white)
                    .onTapGesture {
                        viewStore.send(.savedSummonerTapped(summonerName: summonerNameTag))
                    }
                }
                
            }
            Spacer()
        }
    }
    
}
