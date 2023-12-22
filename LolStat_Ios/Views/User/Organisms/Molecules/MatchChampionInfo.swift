//
//  ChampionInfo.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/19/23.
//

import Foundation
import SwiftUI

struct MatchChampionInfo: View{
    var participant : SimpleParticipant
    var body: some View{
        ChampionIcon(champion: participant.champion, championLevel: participant.championLevel)
        SpellGroup(spells: participant.spells)
        RuneGroup(runes: [participant.mainRune, participant.subRune])
        KDA(kill: participant.kills, death: participant.deaths, assist: participant.assists)
        ItemGroup(items:participant.items)
    }
}
