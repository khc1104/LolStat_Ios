//
//  ChampionIcon.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct ChampionIcon: View{
    let champion : Champion
    let championLevel: Int32
    var body : some View{
        ZStack{
            AsyncImage(url: URL(string:champion.image)){ image in
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
