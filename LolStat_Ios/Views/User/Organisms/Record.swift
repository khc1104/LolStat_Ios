//
//  Record.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//  매치 표시
//

import Foundation
import SwiftUI

struct Record : View{
    let match : SimpleMatch
    var body: some View{
        HStack{
            VStack{
                Text("게임모드")
                    .font(.custom("gamemode", size : 15))
            }.padding()
            ChampionIcon()
            SpellGroup()
            PerkGroup()
            KDA(kill : 2, death : 3, assist : 2)
            ItemGroup()
        }.background(.mint)
    }
}

