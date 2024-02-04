//
//  DuoLoadingRefresh.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/3/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct DuoLoadingRefresh: View {
    let store : StoreOf<AccountStore>
    var body: some View {
        WithViewStore(store, observe: {$0}){viewStore in
            EmptyView()
                .background(.clear)
                .onAppear{
                    viewStore.send(.LoadingOnAppear)
                }
        }
    }
}
