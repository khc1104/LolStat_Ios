//
//  DuoDetailInfo.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoDetailInfo: View {
    var body: some View {
        VStack{
            DuoSummonerName(gameName: "testSummoner", tagLine: "KR1")
            DuoTier(tier: Tier.GOLD)
            DuoTier(tier: Tier.PLATINUM)
            DuoPosition(positions: [Line.MID])
            DuoPosition(positions: [Line.JG, Line.TOP])
            
        }
    }
}

struct duoDetailInfoPreview : PreviewProvider{
    static var previews: some View{
        DuoDetailInfo()
    }
}
