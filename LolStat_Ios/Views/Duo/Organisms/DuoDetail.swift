//
//  DuoDetail.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct DuoDetail: View {
    let store : StoreOf<DuoStore>
    var body: some View {
        WithViewStore(store, observe: {$0}){ viewStore in
            if let duoDetail = viewStore.duoDetail{
                VStack{
                    DuoDetailInfo(duo: duoDetail)
                }.toolbar{
                    ToolbarItem{
                        Button("Cancle"){
                            viewStore.send(.duoDetailCancleTapped)
                        }
                    }
                }
            }
        }
    }
}
