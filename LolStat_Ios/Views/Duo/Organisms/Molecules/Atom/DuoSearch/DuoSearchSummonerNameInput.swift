//
//  DuoSearchSummonerNameInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoSearchSummonerNameInput: View {
    @Binding var gameName : String
    var body: some View {
        TextField("소환사이름", text: $gameName)
    }
}
