//
//  MatchQueueIdPicker.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/20/24.
//

import Foundation
import SwiftUI

struct MatchQueueIdPicker: View {
    @Binding var selectedMatch : QueueId
    var body: some View {
        Picker("QueueId", selection: $selectedMatch){
            Text(QueueId.ALL.description()).tag(QueueId.ALL)
            Text(QueueId.SOLO_RANK_GAME.description()).tag(QueueId.SOLO_RANK_GAME)
            Text(QueueId.FLEX_RANK_GAME.description()).tag(QueueId.FLEX_RANK_GAME)
            Text(QueueId.QUICK_PLAY.description()).tag(QueueId.QUICK_PLAY)
        }
        .pickerStyle(SegmentedPickerStyle())
        .font(.kingSejong(.regular, size: 14))
    }
}
