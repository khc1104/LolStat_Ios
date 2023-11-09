//
//  SummonerIcon.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//

import Foundation
import SwiftUI

struct SummonerIcon: View{
    let imageUrl : String = "https://i.pravatar.cc/150?img=68"
    let summonerLevel : Int64 = 99
    var body : some View{
        ZStack{
            AsyncImage(url: URL(string:imageUrl))
                .frame(width: 100, height: 100)
                .cornerRadius(30)
            
                
            Text("\(summonerLevel)")
                .foregroundColor(Color.white)
                .background(Color.brown)
                .clipShape(
                    Capsule()
                )
                .padding()
                .offset(y:50)
        }
    }
}
