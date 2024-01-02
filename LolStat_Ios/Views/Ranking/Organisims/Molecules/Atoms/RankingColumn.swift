//
//  RankingColumn.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/28/23.
//

import Foundation
import SwiftUI

struct RankingColumn: View {
    var body: some View {
        HStack(alignment:.center){
                Text("순위")
                    .frame(width:Const.Screen.WIDTH*0.2)
                Text("소환사")
                    .frame(width: Const.Screen.WIDTH*0.5)
                Text("LP")
                    .frame(width: Const.Screen.WIDTH*0.3)
                
            }
            .background(.gray)
    }
}

struct Preview_RankingColumn: PreviewProvider{
    static var previews: some View{
        RankingColumn()
    }
}
