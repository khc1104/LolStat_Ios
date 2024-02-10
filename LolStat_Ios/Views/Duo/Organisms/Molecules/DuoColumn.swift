//
//  DuoColumn.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/1/24.
//

import Foundation
import SwiftUI

struct DuoColumn: View {
    let duo : DuoDto
    var body: some View {
        VStack(spacing: 2){
            DuoSummonerName(gameName:duo.gameName, tagLine: duo.tagLine)
                .background(duo.matched ? .winBlue : .loseRed)
            HStack(alignment: .top){
                VStack{
                    Text("티어")
                    DuoTier(tiers: [duo.tier], width: 50, height: 50)
                }
                .frame(width: Const.Screen.WIDTH * 0.2)
                VStack{
                    Text("주 포지션")
                    DuoPosition(positions: duo.lines)
                }
                .frame(width: Const.Screen.WIDTH * 0.2)
                VStack{
                    Text("찾는 포지션")
                    DuoPosition(positions: duo.wishLines)
                }
                .frame(width: Const.Screen.WIDTH * 0.2)
                VStack{
                    Text("등록일")
                    DuoDate(date: duo.createdAt)
                    Spacer()
                    Text("만료일")
                    DuoDate(date : duo.expiredAt)
                    
                }
                .frame(width: Const.Screen.WIDTH * 0.3)
            }
            //Spacer()
            HStack{
                DuoMemo(memo: duo.memo)
            }
            .frame(width: Const.Screen.WIDTH)
            .background(.winBlue)
        }
        .background(.secondary)
        .frame(width: Const.Screen.WIDTH, height: 210)
        .cornerRadius(8)
    }
}
