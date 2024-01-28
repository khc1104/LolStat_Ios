//
//  UserVerify.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/28/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct UserVerify: View {
    let store : StoreOf<AccountStore> = LolStat_IosApp.accountStore
    var body: some View {
        UserVerifyGroup(store: store)
    }
}
