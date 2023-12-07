//
//  SummonerInfo.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//

import Foundation
import SwiftUI

struct SummonerInfo : View{
    
    var body : some View{
            HStack{
                SummonerIcon()
                SummonerName()
                SummonerTier()
            }
        }
}
