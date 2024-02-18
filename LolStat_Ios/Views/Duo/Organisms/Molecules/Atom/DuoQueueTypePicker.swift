//
//  DuoQueueTypePicker.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/18/24.
//

import Foundation
import SwiftUI

struct DuoQueueTypePicker : View {
    @Binding var selectedQueue : DuoQueueId
    var body: some View {
        Picker("QueueId", selection: $selectedQueue){
            Text(DuoQueueId.ALL.description()).tag(DuoQueueId.ALL)
            Text(DuoQueueId.SOLO_RANK_GAME.description()).tag(DuoQueueId.SOLO_RANK_GAME)
            Text(DuoQueueId.FLEX_RANK_GAME.description()).tag(DuoQueueId.FLEX_RANK_GAME)
            Text(DuoQueueId.QUICK_PLAY.description()).tag(DuoQueueId.QUICK_PLAY)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
