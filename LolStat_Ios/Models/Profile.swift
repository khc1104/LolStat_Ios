//
//  Profile.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//


struct Profile : Codable, Equatable{
    let puuid : String
    let gameName : String
    let tagLine : String
    let summonerName : String
    let summonerLevel :Int64
    let profileIcon : String
    let soloLeagueEntry : LeagueEntry
    let flexLeagueEntry : LeagueEntry
    }
    
struct LeagueEntry : Codable, Equatable{
    let queueType : QueueType
    let tier : Tier
    let rank: Rank
    let leaguePoints : Int32
    let wins : Int32
    let losses : Int32
}


