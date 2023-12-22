//
//  PerkIcon.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct RuneIcon: View{
    let rune : Rune
    let summonerLevel : Int64 = 99
    var body : some View{
        if rune.image == ""{
            Rectangle()
                .background(.white)
                .frame(width: 24, height: 24)
        }
        
        AsyncImage(url: URL(string:rune.image)){ image in
                image.image?.resizable()
            }
                .frame(width: 24, height: 24)
        }
}
