//
//  DuoTicketSummonerName.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/8/24.
//

import Foundation
import SwiftUI

struct DuoTicketSummonerName:View {
    let gameName : String
    let tagLine : String
    var body: some View {
        HStack{
            Text(gameName)
            Text("#\(tagLine)")
                .foregroundStyle(.secondary)
        }
    }
}
