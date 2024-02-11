//
//  DuoSearchTier.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/11/24.
//

import Foundation
import SwiftUI

struct DuoSearchTier: View {
    var tier : Tier = Tier.EMERALD
    var isSelect : Bool = false
    var body: some View {
        ZStack{
            Image(tier.image()).resizable()
        }
        .frame(width:40, height: 40)
        .background(isSelect ? .mint : .secondary)
    }
}

struct DuoSearchTierPreview : PreviewProvider{
    static var previews: some View{
        DuoSearchTier()
    }
    
}
