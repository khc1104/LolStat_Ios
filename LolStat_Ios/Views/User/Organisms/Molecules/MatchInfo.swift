//
//  Record.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//  매치 표시
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct MatchInfo : View{
    let match : SimpleMatch
    var body: some View{
        HStack{
            MatchChampionInfo(participant: match.participants.first!)
                .frame(width:Const.Screen.WIDTH * 0.7)
            
            VStack{
                Text(match.queueId.description())
                    .font(.kingSejong(.regular, size:15))
                    .frame(width: Const.Screen.WIDTH * 0.3)
                    .padding()
                Spacer()
            }
            
        }
        .frame(width: Const.Screen.WIDTH)
        .background(
            match.participants.first!.win ?
                .mint : .pink
        )
    }
}



