//
//  DuoSearchQueueIdInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoSearchQueueIdInput:View {
    @Binding var selectedQueue : DuoQueueId
    //var options: [String]
    var body: some View {
            Picker("QueueId", selection: $selectedQueue){
                Text(DuoQueueId.SOLO_RANK_GAME.description()).tag(DuoQueueId.SOLO_RANK_GAME)
                Text(DuoQueueId.FLEX_RANK_GAME.description()).tag(DuoQueueId.FLEX_RANK_GAME)
                Text(DuoQueueId.QUICK_PLAY.description()).tag(DuoQueueId.QUICK_PLAY)
            }
            .pickerStyle(SegmentedPickerStyle())
    }
}
