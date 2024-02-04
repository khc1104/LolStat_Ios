//
//  DuoDetailQueueType.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoDetailQueueType: View {
    var queueId : DuoQueueId = .QUICK_PLAY
    var body: some View {
        Text(queueId.description())
    }
}
