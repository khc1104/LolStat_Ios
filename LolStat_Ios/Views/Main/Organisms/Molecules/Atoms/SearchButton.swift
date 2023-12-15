//
//  SearchButton.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/08.
//

import ComposableArchitecture
import SwiftUI

struct SearchButton :View{
    let store : StoreOf<MainStore>
    
    var body: some View{
        WithViewStore(self.store, observe: { $0 }){ viewStore in
            Button("search"){
                //viewStore.send(.searchButtonTapped(summonerName: viewStore.summonerName))
            }
            .padding()
            .frame(width:Const.Screen.WIDTH * 0.2 - 10, height: 60)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8
                )
            )
            .foregroundColor(viewStore.summonerName == "" ? .gray : .pink)
            .background(Color(uiColor: .secondarySystemBackground))
        }
    }
}
