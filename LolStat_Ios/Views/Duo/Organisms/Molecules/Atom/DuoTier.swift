//
//  DuoTier.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/31/24.
//

import Foundation
import SwiftUI

struct DuoTier : View {
    let tiers : [Tier]
    var width : CGFloat = 40
    var height : CGFloat = 40
    var body: some View {
        HStack{
            ForEach(tiers, id:\.self){ tier in
                Image(tier.image()).resizable()
                    .frame(width: width, height: height)
            }
        }
    }
}
