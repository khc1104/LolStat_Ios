//
//  DuoMatchPicker.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/18/24.
//

import Foundation
import SwiftUI

struct DuoMatchPicker: View {
    @Binding var selectedMatch : DuoIsMatch
    var body: some View {
        Picker("IsMatched", selection: $selectedMatch){
            Text(DuoIsMatch.ALL.description()).tag(DuoIsMatch.ALL)
            Text(DuoIsMatch.MATCHING.description()).tag(DuoIsMatch.MATCHING)
            Text(DuoIsMatch.MATCHED.description()).tag(DuoIsMatch.MATCHED)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
