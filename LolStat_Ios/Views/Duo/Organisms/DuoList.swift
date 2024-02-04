//
//  DuoList.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/1/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct DuoList: View {
    let store : StoreOf<DuoStore>
    var body: some View {
        WithViewStore(store, observe: {$0}){viewStore in
            ScrollView{
                Text("Duo")
                Button("LogOut"){
                    viewStore.send(.logOutButtonTapped)
                }
                
                if let duoList = viewStore.duoList{
                    ForEach(duoList){ duo in
                        DuoColumn(duo: duo)
                    }
                }
            }
        }
    }
}
