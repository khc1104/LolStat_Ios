//
//  DuoTicketRecentlyChampions.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoTicketRecentlyChampions: View {
    var matches : [DuoRecentMatchDto] = [DuoRecentMatchDto(championDto: Champion(name: "르블랑", description: "",image: "https://image.lolstat.net/champion/Leblanc.png"), kills: 5, deaths: 6, assists: 1, win: true),DuoRecentMatchDto(championDto: Champion(name: "르블랑", description: "",image: "https://image.lolstat.net/champion/Leblanc.png"), kills: 5, deaths: 6, assists: 1, win: true),DuoRecentMatchDto(championDto: Champion(name: "르블랑", description: "",image: "https://image.lolstat.net/champion/Leblanc.png"), kills: 5, deaths: 6, assists: 1, win: true),DuoRecentMatchDto(championDto: Champion(name: "르블랑", description: "",image: "https://image.lolstat.net/champion/Leblanc.png"), kills: 5, deaths: 6, assists: 1, win: false),DuoRecentMatchDto(championDto: Champion(name: "르블랑", description: "",image: "https://image.lolstat.net/champion/Leblanc.png"), kills: 5, deaths: 6, assists: 1, win: true)]
    var body: some View {
        HStack(spacing:0){
            ForEach(0..<matches.count, id : \.self){ i in
                DuoTicketChampion(match: matches[i])
            }
        }
    }
}
