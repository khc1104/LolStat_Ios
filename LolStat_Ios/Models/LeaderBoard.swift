//
//  LeaderBoard.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/26/23.
//

import Foundation

struct LeaderBoard : Codable, Equatable{
    let tier: String
    let queue: String?
    let players: [LeaderBoardPlayer]
}

struct LeaderBoardPlayer: Codable, Identifiable, Equatable{
    var id :String {summonerId}
    
    let summonerId: String
    let summonerName: String
    let rank: String
    let leaguePoints: Int32
    let wins : Int32
    let loses: Int32
}
