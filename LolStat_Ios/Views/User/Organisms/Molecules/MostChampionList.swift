//
//  MostChampionList.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/10/24.
//

import Foundation
import SwiftUI

struct MostChampionList: View {
    let mostChampions : [MostChampion]
    var body: some View {
        HStack{
            ForEach(0..<3){ i in
                MostChampionCard(mostChampion: mostChampions[i])
                    .padding(3)
            }
        }
        .background(.secondMost)
        .cornerRadius(8)
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
    }
}
