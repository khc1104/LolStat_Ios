//
//  DuoSearchWishTierInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoSearchWishTierInput: View {
    @Binding var tiers : [Tier : Bool]
    var body: some View {
        HStack(spacing: 0){
            DuoSearchTier(tier: Tier.UNRANKED, isSelect: tiers[Tier.UNRANKED]!)
                .onTapGesture {
                    tiers[Tier.UNRANKED]?.toggle()
                }
            DuoSearchTier(tier: Tier.IRON, isSelect: tiers[Tier.IRON]!)
                .onTapGesture {
                    tiers[Tier.IRON]?.toggle()
                }
            DuoSearchTier(tier: Tier.BRONZE, isSelect: tiers[Tier.BRONZE]!)
                .onTapGesture {
                    tiers[Tier.BRONZE]?.toggle()
                }
            DuoSearchTier(tier: Tier.SILVER, isSelect: tiers[Tier.SILVER]!)
                .onTapGesture {
                    tiers[Tier.SILVER]?.toggle()
                }
            DuoSearchTier(tier: Tier.GOLD, isSelect: tiers[Tier.GOLD]!)
                .onTapGesture {
                    tiers[Tier.GOLD]?.toggle()
                }
            DuoSearchTier(tier: Tier.PLATINUM, isSelect: tiers[Tier.PLATINUM]!)
                .onTapGesture {
                    tiers[Tier.PLATINUM]?.toggle()
                }
            DuoSearchTier(tier: Tier.EMERALD, isSelect: tiers[Tier.EMERALD]!)
                .onTapGesture {
                    tiers[Tier.EMERALD]?.toggle()
                }
            DuoSearchTier(tier: Tier.DIAMOND, isSelect: tiers[Tier.DIAMOND]!)
                .onTapGesture {
                    tiers[Tier.DIAMOND]?.toggle()
                }
            DuoSearchTier(tier: Tier.MASTER, isSelect: tiers[Tier.MASTER]!)
                .onTapGesture {
                    tiers[Tier.MASTER]?.toggle()
                }
            DuoSearchTier(tier: Tier.GRANDMASTER, isSelect: tiers[Tier.GRANDMASTER]!)
                .onTapGesture {
                    tiers[Tier.GRANDMASTER]?.toggle()
                }
            DuoSearchTier(tier: Tier.CHALLENGER, isSelect: tiers[Tier.CHALLENGER]!)
                .onTapGesture {
                    tiers[Tier.CHALLENGER]?.toggle()
                }
        }
    }
}
/*
struct whishTierPreview : PreviewProvider{
    static var previews: some View{
        DuoSearchWishTierInput()
    }
}
*/
