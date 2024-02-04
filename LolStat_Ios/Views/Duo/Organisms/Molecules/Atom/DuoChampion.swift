//
//  DuoChmpion.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoChampion: View {
    
    
    
    
    var match : DuoRecentMatchDto = DuoRecentMatchDto(championDto: Champion(name: "르블랑", description: "", image: "https://image.lolstat.net/champion/Leblanc.png"), kills: 5, deaths: 6, assists: 12, win: true)
    var body: some View {
        ZStack{
            VStack{
                AsyncImage(url: URL(string: match.championDto.image)){image in
                    image.image?.resizable()
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
    }
}


struct DuoChampionPreview : PreviewProvider{
    static var previews: some View{
        DuoChampion()
    }
}


