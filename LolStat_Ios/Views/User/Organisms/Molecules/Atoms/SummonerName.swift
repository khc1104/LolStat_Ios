//
//  SummonnerName.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/17.
//

import Foundation
import SwiftUI

struct SummonerName : View{
    let gameName : String
    let tagLine : String
    
    var body : some View {
        Text("\(gameName)")
            .font(.kingSejong(.bold, size: 17))
        Text("#\(tagLine)")
            .font(.kingSejong(.regular, size: 12))
            .foregroundStyle(.secondary)
    }
}
