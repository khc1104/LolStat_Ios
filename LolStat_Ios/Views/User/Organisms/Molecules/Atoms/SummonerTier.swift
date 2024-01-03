//
//  SummonerTier.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//

import Foundation
import SwiftUI

struct SummonerTier : View{
    var rankInfo : LeagueEntry
    
    var body : some View{
        VStack{
            ZStack{
                Text(rankInfo.queueType.description())
                    .foregroundStyle(.white)
                    
            }
            .frame(width: Const.Screen.WIDTH*0.7, height: 35)
            .background(.black)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8
                )
            )
            HStack{
                ZStack{
                    var imageUrl: String = Const.Server.IMGAGE_ADDRESS + rankInfo.tier.imageUrl()

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
                .frame(width: 70, height: 70)
                
                Text(rankInfo.tier.description())
                Text(rankInfo.rank.description())
                if rankInfo.tier != .UNRANKED{
                    Text("\(rankInfo.leaguePoints)lp")
                    VStack{
                        
                        Text("\(rankInfo.wins)승\(rankInfo.losses)패")
                        
                        Text("승률\(getPercent(wins:rankInfo.wins ,losses:rankInfo.losses))%")
                    }
                    .font(.custom("percent", fixedSize: 10))
                }
                
            }
        }
    }
    
    func getPercent(wins:Int32, losses:Int32) -> Int{
        if wins+losses > 0{
            var percent = Float(wins)/Float(wins+losses) * 100
            return Int(percent.rounded())
        }else{
            return 0
        }
    }
}
