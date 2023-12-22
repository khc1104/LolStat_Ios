//
//  SpellIcon.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct SpellIcon: View{
    let spell : Spell
    let summonerLevel : Int64 = 99
    var body : some View{
        if spell.image == ""{
            Rectangle()
                .background(.white)
                .frame(width: 24, height: 24)
        }
        else{
            AsyncImage(url: URL(string:spell.image)){ image in
                image.image?.resizable()
            }
            .frame(width: 24, height: 24)
        }
    }
}

