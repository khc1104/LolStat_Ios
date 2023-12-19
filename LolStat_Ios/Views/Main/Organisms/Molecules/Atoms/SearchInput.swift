//
//  Search.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/06.
//

import SwiftUI
import ComposableArchitecture

struct SearchInput: View{
    let store: StoreOf<MainStore>
    
    var body: some View{
        WithViewStore(self.store, observe: { $0 }){ viewStore in
            TextField("플레이어 이름", text: viewStore.$summonerName)
                .padding()
                .frame(width: Const.Screen.WIDTH * 0.8 - 10, height: 60)
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 8
                    )
                )
        }
        
    }
}



