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
            if champion.image == ""{
                ZStack{
                    Rectangle()
                        .frame(width: 50, height:50)
                        .background(.white)
                        .opacity(0.2)
                    Text("이미지가 없습니다")
                        .font(.kingSejong(.regular, size: 10))
                }
            }else{
                AsyncImage(url: URL(string:champion.image)){ image in
                    image.image?.resizable()
                }
                .frame(width: 50, height: 50)
            }
                
            Text("\(championLevel)")
                .foregroundColor(Color.white)
                .background(Color.black)
                .offset(x:15, y:15)
                .font(.custom("ChampionIcon", size: 15))
        }
    }
}
