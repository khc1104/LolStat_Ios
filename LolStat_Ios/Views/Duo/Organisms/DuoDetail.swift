//
//  DuoDetail.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoDetail: View {
    var body: some View {
        VStack{
            DuoSummonerName(gameName: "testSummoner", tagLine: "KR1")
            DuoTier(tier: Tier.GOLD)
            //DuoTier
        }
    }
}

struct duoDetailPreview : PreviewProvider{
    static var previews: some View{
        DuoDetail()
    }
}
