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
                .padding(.vertical, 5)
            SpellGroup(spells: participant.spells)
            RuneGroup(runes: [participant.mainRune, participant.subRune])
            VStack{
                Text(participant.summonerName)
                KDA(kill: participant.kills, death: participant.deaths, assist: participant.assists)
                    
            }
            .frame(width: Const.Screen.WIDTH * 0.2)
            .font(.kingSejong(.regular))
            ItemGroup(items:participant.items, size: 24)
                
        }
        .foregroundStyle(.white)
        .background(participant.win == true ? .winBlue : .loseRed)
        .frame(width: Const.Screen.WIDTH)
    }
}
