//
//  Login.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/22/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct Login: View {
    let store : StoreOf<AccountStore>
    var body: some View {
        LoginInputGroup(store: store)
        
    }
}
