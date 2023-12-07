//
//  ItemIcon.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct ItemIcon: View{
    let imageUrl : String = "https://image.lolstat.net/item/1056.png"
    let summonerLevel : Int64 = 99
    var body : some View{
            AsyncImage(url: URL(string:imageUrl)){ image in
                image.image?.resizable()
            }
                .frame(width: 24, height: 24)
        }
}
