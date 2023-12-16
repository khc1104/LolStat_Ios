//
//  SummonerIcon.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//

import Foundation
import SwiftUI

struct SummonerIcon: View{
    var profileIcon : String = "https://i.pravatar.cc/150?img=68"
    let summonerLevel : Int64 = 99
    var body : some View{
        ZStack{
            AsyncImage(url: URL(string:profileIcon)){image in
                image.image?.resizable()
            }
                
            .frame(width: 50, height: 50)
            //.cornerRadius(30)
            .clipShape(Circle())
            
                
            Text("\(summonerLevel)")
                .foregroundColor(Color.white)
                .background(Color.black)
                .offset(y:15)
                .font(.custom("ChampionIcon", size: 15))
                .clipShape(Capsule())
        }
    }
}
