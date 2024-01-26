//
//  NewAccount.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/19/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct Join: View {
    let store : StoreOf<JoinStore>
    /*= Store(initialState: JoinStore.State()){
     JoinStore()
     }
     */
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            VerifyGroup(store : store)
        }
    }
}
