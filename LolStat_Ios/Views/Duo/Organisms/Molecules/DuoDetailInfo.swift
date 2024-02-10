//
//  DuoDetailInfo.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoDetailInfo: View {
    var duo : DuoDto
    var body: some View {
        VStack{
            DuoSummonerName(gameName: duo.gameName, tagLine: duo.tagLine)
            HStack{
                VStack{
                    Text("티어")
                    DuoTier(tiers: [duo.tier], width: 60, height: 60)
                }
                VStack{
                    Text("찾는 티어")
                    DuoTier(tiers: duo.wishTiers, width:60, height: 60)
                }
            }
            Text("주 포지션")
            DuoDetailPosition(lines: duo.lines)
            Text("찾는 포지션")
            DuoDetailPosition(lines: duo.wishLines)
            Text("큐 타입")
            DuoDetailQueueType()
            DuoDetailRecentlyMatches(matches: duo.recentMatches)
            DuoMemo(memo: duo.memo)
            
            
        }
    }
}

