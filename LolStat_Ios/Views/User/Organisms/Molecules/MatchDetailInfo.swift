//
//  MatchDetailInfo.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/24/23.
//

import Foundation
import SwiftUI

struct MatchDetailInfo : View {
    let participant: SimpleParticipant
    
    var body: some View {
        
        HStack{
            Text(participant.summonerName)
                .frame(width: 80)
            MatchChampionInfo(participant: participant)
        }
        .background(participant.win == true ? .blue : .pink)
        .frame(minWidth: Const.Screen.WIDTH)
    }
}
