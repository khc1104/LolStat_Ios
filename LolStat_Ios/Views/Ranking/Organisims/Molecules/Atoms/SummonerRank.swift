//
//  SummonerRank.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/28/23.
//

import Foundation
import SwiftUI

struct SummonerRank:View {
    let rank : Int
    let summoner : LeaderBoardPlayer
    
    var body: some View {
        VStack{
            HStack{
                Text("\(rank)")
                    .frame(width:Const.Screen.WIDTH*0.2)
                Text(summoner.summonerName)
                    .frame(width: Const.Screen.WIDTH*0.5)
                Text("\(summoner.leaguePoints)")
                    .frame(width: Const.Screen.WIDTH*0.3)

            }
            Winrate(wins: summoner.wins, loses: summoner.loses)
        }
        .background(.white)
    }
}
