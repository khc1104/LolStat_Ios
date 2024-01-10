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
        ForEach(0..<3){ i in
            MostChampionCard(mostChampion: mostChampions[i])
        }
    }
}
