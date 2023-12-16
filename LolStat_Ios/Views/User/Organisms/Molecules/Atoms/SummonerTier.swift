//
//  SummonerTier.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//

import Foundation
import SwiftUI

struct SummonerTier : View{
    var queueType : String = "Solo Ranked"
    var tier : String = "Gold"
    
    var body : some View{
        ZStack{
            Spacer()
                
            VStack{
                Text(queueType)
                Text(tier)
            }
        }
    }
}

