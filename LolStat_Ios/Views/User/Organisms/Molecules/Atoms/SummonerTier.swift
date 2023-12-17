//
//  SummonerTier.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//

import Foundation
import SwiftUI

struct SummonerTier : View{
    //var rankInfo : LeagueEntry
    var queueType : String = "솔로 랭크"
    var tier : String = "골드"
    var imageUrl: String = "https://www.lolstat.net/gold.webp"
    var rank: String = "4"
    var rankPoint: Int = 69
    var wins: Int = 3
    var losses: Int = 2
    
    var body : some View{
        VStack{
            ZStack{
                Text(queueType)
                    .foregroundStyle(.white)
                    
            }
            .frame(width: Const.Screen.WIDTH*0.48, height: 35)
            .background(.black)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8
                )
            )
            HStack{
                ZStack{
                    AsyncImage(url: URL(string:imageUrl)){image in
                        image.image?.resizable()
                    }
                    //.padding()
                    .frame(width: 50, height: 50)
                }
                .background(.quaternary)
                .clipShape(
                    Circle()
                )
                //.frame(width: 70, height: 70)
                Text(tier)
                Text(rank)
                Text("\(rankPoint)lp")
                VStack{
                    Text("\(wins)승\(losses)패")
                    let percent = wins/(wins+losses)*100
                    Text("승률\(percent)%")
                }
                .font(.custom("percent", fixedSize: 10))
            }
        }
    }
}
/*
struct Preview_SummonerInfo: PreviewProvider{
    static var previews: some View{
        SummonerInfo()
    }
}
*/
