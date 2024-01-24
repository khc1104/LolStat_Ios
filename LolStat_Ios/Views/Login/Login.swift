//
//  Login.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/22/24.
//

import Foundation
import SwiftUI

struct Login: View {
    var body: some View {
        LoginInputGroup(store: LolStat_IosApp.accountStore)
    }
}
