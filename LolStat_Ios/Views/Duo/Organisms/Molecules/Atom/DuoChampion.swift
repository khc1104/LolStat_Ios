//
//  DuoChmpion.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoChampion: View {
    var match : DuoRecentMatchDto = DuoRecentMatchDto(championDto: Champion(name: "르블랑", description: "", image: "https://image.lolstat.net/champion/Leblanc.png"), kills: 5, deaths: 6, assists: 12, win: false)
    var body: some View {
        ZStack{
            VStack{
                AsyncImage(url: URL(string: match.championDto.image)){image in
                    image.image?.resizable()
                        .frame(width:50, height: 50)
                    HStack{
                        Text("\(match.kills)")
                        Text("/")
                        Text("\(match.deaths)")
                        Text("/")
                        Text("\(match.assists)")
                    }
                }
                
            }
        }
        .frame(width: 80, height: 80)
        .font(.kingSejong(.bold, size: 12))
        .foregroundColor(.white)
        .background(match.win ? .winBlue : .loseRed)
    }
}


struct DuoChampionPreview : PreviewProvider{
    static var previews: some View{
        DuoChampion()
    }
}


