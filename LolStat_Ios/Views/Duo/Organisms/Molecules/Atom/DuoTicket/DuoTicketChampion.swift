//
//  DuoTicketChampion.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoTicketChampion:View {
    var match : DuoRecentMatchDto = DuoRecentMatchDto(championDto: Champion(name: "르블랑", description: "", image: "https://image.lolstat.net/champion/Leblanc.png"), kills: 5, deaths: 6, assists: 12, win: false)
    var body: some View {
        AsyncImage(url:URL(string:match.championDto.image)){ image in
            image.image?.resizable()
        }
        .frame(width: 30, height: 30)
    }
}
