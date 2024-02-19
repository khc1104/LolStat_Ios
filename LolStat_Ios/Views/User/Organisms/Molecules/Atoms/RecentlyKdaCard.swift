//
//  recentlyKDA.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/3/24.
//

import Foundation
import SwiftUI

struct RecentlyKdaCard: View {
    let KDA : [Int32]
    var body: some View {
        ZStack{
            VStack{
                Text("최근 KDA")
                HStack(spacing:0){
                    Text("\(KDA[0])/")
                    Text("\(KDA[1])")
                        .foregroundStyle(.red)
                    Text("/")
                    Text("\(KDA[2])")
                }
            }
        }
        .frame(width: 100, height: 100)
        .background(.secondary)
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
        //.font(.kingSejong(.regular))
    }
}
