//
//  ItemIcon.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct ItemIcon: View{
    let item: Item
    var body : some View{
        if item.image == ""{
            Rectangle()
                .frame(width: 24, height:24)
                .background(.white)
        }else{
            AsyncImage(url: URL(string:item.image)){ image in
                image.image?.resizable()
            }
            .frame(width: 24, height: 24)
        }
    }
}
