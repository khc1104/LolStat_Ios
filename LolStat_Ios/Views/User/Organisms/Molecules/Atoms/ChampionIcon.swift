//
//  ChampionIcon.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct ChampionIcon: View{
    let imageUrl : String = "https://image.lolstat.net/champion/Akali.png"
    let championLevel : Int64 = 99
    var body : some View{
        ZStack{
            AsyncImage(url: URL(string:imageUrl)){ image in
                image.image?.resizable()
            }
            .frame(width: 50, height: 50)
            
                
            Text("\(championLevel)")
                .foregroundColor(Color.white)
                .background(Color.black)
                .offset(x:15, y:15)
                .font(.custom("ChampionIcon", size: 15))
        }
    }
}
