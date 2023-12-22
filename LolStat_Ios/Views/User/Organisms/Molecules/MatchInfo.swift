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
            VStack{
                Text(match.queueId.description())
                    .font(.custom("gamemode", size : 15))
            }.padding()
            MatchChampionInfo(participant: match.participants.first!)
        }
        .frame(width: Const.Screen.WIDTH)
        .background(
            match.participants.first!.win ?
                .mint : .pink
            
        )
    }
}



