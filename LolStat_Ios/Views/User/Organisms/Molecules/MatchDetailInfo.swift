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
            ChampionIcon(champion: participant.champion, championLevel: participant.championLevel)
            SpellGroup(spells: participant.spells)
            RuneGroup(runes: [participant.mainRune, participant.subRune])
            VStack{
                Text(participant.summonerName)
                KDA(kill: participant.kills, death: participant.deaths, assist: participant.assists)
                    
            }
            .frame(width: Const.Screen.WIDTH * 0.2)
            .font(.custom("matchdetail_summonername", fixedSize: 12))
            ItemGroup(items:participant.items, size: 24)
        }
        .background(participant.win == true ? .blue : .pink)
        .frame(width: Const.Screen.WIDTH)
    }
}
