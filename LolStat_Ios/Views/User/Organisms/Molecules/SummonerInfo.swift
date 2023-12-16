//
//  SummonerInfo.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//

import Foundation
import SwiftUI

struct SummonerInfo : View{
    
    let profile :Profile
    var body : some View{
            HStack{
                SummonerIcon(profileIcon: profile.profileIcon)
                SummonerName(summonerName: profile.summonerName)
                SummonerTier(queueType: profile.soloLeagueEntry.queueType.description())
                SummonerTier(queueType: profile.flexLeagueEntry.queueType.description())
                
            }
        }
}
