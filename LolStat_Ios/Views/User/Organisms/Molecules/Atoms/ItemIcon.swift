//
//  ItemIcon.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct ItemIcon: View{
    let item : Item
    let size : CGFloat
    var body : some View{
        if item.imageUrl == ""{
            Rectangle()
                .frame(width: size, height:size)
                .background(.white)
        }else{
            AsyncImage(url: URL(string:item.imageUrl)){ image in
                image.image?.resizable()
            }
            .frame(width: size, height: size)
        }
    }
}
