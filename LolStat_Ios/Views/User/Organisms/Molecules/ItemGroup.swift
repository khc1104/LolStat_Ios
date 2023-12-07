//
//  ItemGroup.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct ItemGroup : View{
    var body : some View{
        HStack(spacing : 1){
            VStack(spacing : 1){
                HStack(spacing : 1){
                    ForEach(1..<4){ i in
                        ItemIcon()
                    }
                }
                HStack(spacing : 1){
                    ForEach(4..<7){ i in
                        ItemIcon()
                    }
                }
            }
            ItemIcon()
        }
    }
}
