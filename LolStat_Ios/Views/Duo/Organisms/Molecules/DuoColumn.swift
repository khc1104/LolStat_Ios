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
            HStack(alignment: .top){
                Text("티어")
                    .frame(width: Const.Screen.WIDTH * 0.2)
                Text("주 포지션")
                    .frame(width: Const.Screen.WIDTH * 0.2)
                Text("찾는 포지션")
                    .frame(width: Const.Screen.WIDTH * 0.2)
                Text("유효기간")
                    .frame(width: Const.Screen.WIDTH * 0.3)
            }
            .background(.gray)
            .frame(width: Const.Screen.WIDTH)
            .font(.kingSejong(.bold, size: 16))
            HStack(alignment: .top){
                VStack{
                    DuoTier(tier: duo.tier, width: 50, height: 50)
                }
                .frame(width: Const.Screen.WIDTH * 0.2)
                VStack{
                    DuoPosition(positions: duo.lines)
                }
                .frame(width: Const.Screen.WIDTH * 0.2)
                VStack{
                    DuoPosition(positions: duo.wishLines)
                }
                .frame(width: Const.Screen.WIDTH * 0.2)
                VStack{
                    DuoExpDate(date : duo.expiredAt)
                }
                .frame(width: Const.Screen.WIDTH * 0.3)
            }
            Spacer()
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
