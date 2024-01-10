//
//  MostChampion.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/10/24.
//

import Foundation
import SwiftUI

struct MostChampionCard : View {
    let mostChampion : MostChampion
    
    var body: some View {
        ZStack{
            VStack{
                Text("모스트\(mostChampion.order)")
                HStack{
                    AsyncImage(url: URL(string:mostChampion.champion.image)){image in
                        image.image?.resizable()
                    }
                    .frame(width: 40, height: 40)
                    Text("\(mostChampion.count)회")
                }
                
            }
            .frame(width: 80, height: 80)
            .background(mostChampion.order == 1 ? .firstMost :
                            mostChampion.order == 2 ? .secondMost :
                            mostChampion.order == 3 ? .thirdMost :
                    .secondary)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            //.font(.kingSejong(.regular))
        }
    }
}

