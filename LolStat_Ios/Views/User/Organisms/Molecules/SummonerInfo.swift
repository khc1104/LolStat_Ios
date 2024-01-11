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
        VStack{
            HStack{
                SummonerIcon(profileIcon: profile.profileIcon)
                SummonerName(gameName: profile.gameName, tagLine: profile.tagLine)
            }
            ScrollView(.horizontal){
                HStack{
                    SummonerTier(rankInfo: profile.soloLeagueEntry)
                    SummonerTier(rankInfo: profile.flexLeagueEntry)
                }
            }
        }
        
    }
}
