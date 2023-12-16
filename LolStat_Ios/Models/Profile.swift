//
//  Profile.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//


struct Profile : Codable, Equatable{
        
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
enum QueueType : String, Codable{
    case RANKED_SOLO = "RANKED_SOLO"
    case RANKED_TEAM = "RANKED_TEAM"
    case UNKNOWN = "UNKNOWN"
    
    func description() -> String{
        switch self{
        case .RANKED_SOLO:
            return "솔로 랭크"
        case .RANKED_TEAM:
            return "자유 랭크"
        case .UNKNOWN:
            return "UNRANKED"
        }
    }
}
enum Tier : String, Codable{
    case CHALLENGER = "CHALLENGER"
    case GRANDMASTER = "GRANDMASTER"
    case MASTER = "MASTER"
    case DIAMOND = "DIAMOND"
    case EMERALD = "EMERALD"
    case PLATINUM = "PLATINUM"
    case GOLD = "GOLD"
    case SILVER = "SILVER"
    case BRONZE = "BRONZE"
    case IRON = "IRON"
    case UNRANKED = "UNRANKED"
    
    func description() -> String{
        switch self{
        case .CHALLENGER:
            return "챌린저"
        case .GRANDMASTER:
            return "그랜드마스터"
        case .MASTER:
            return "마스터"
        case .DIAMOND:
            return "다이아몬드"
        case .EMERALD:
            return "에메랄드"
        case .PLATINUM:
            return "플래티넘"
        case .GOLD:
            return "골드"
        case .SILVER:
            return "실버"
        case .BRONZE:
            return "브론즈"
        case .IRON:
            return "아이언"
        case .UNRANKED:
            return "UNRANKED"
        }
    }
}
enum Rank : String, Codable{
    case RANK_ONE = "RANK_ONE"
    case RANK_TWO = "RANK_TWO"
    case RANK_THREE = "RANK_THREE"
    case RANK_FOUR = "RANK_FOUR"
    case UNRANKED = "UNRANKED"
    
    func description() -> String{
        switch self{
        case .RANK_ONE:
            return "I"
        case .RANK_TWO:
            return "II"
        case .RANK_THREE:
            return "III"
        case .RANK_FOUR:
            return "IV"
        case .UNRANKED:
            return "UNRANKED"
        }
    }
}

