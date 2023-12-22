//
//  ItemGroup.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct ItemGroup : View{
    let items: [Item]
    var body : some View{
        HStack(spacing : 1){
            VStack(spacing : 1){
                HStack(spacing : 1){
                    ForEach(0..<3){ i in
                        ItemIcon(item:items[i])
                    }
                }
                HStack(spacing : 1){
                    ForEach(3..<6){ i in
                        ItemIcon(item:items[i])
                    }
                }
            }
            ItemIcon(item:items[6])
        }
    }
}
