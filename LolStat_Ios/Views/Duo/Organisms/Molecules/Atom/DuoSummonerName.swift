//
//  DuoSummonerName.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/31/24.
//

import Foundation
import SwiftUI

struct DuoSummonerName: View {
    let gameName : String
    let tagLine : String
    var size : CGFloat = 16
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .center){
                HStack(alignment: .bottom){
                    Text(gameName)
                        .font(.kingSejong(.regular, size: size))
                    Text("#\(tagLine)")
                        .font(.kingSejong(.regular, size: 12))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: geo.size.width)
            //.background(.mint)
        }
        .frame(height: 20)
    }
}

