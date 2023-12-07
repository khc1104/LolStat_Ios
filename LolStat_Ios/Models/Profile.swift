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
        enum queueType : String{
            case RANKED_SOLO = "솔로/듀오"
            case RANKED_TEAM = "자유랭크"
            case UNKNOWN = "기타"
        }
        enum tier : String{
            case CHALLENGER = "첼린저"
            case GRANDMASTER = "그랜드마스터"
            case MASTER = "마스터"
            case DIAMOND = "다이아몬드"
            case EMERALD = "에메랄드"
            case PLATINUM = "플래티넘"
            case GOLD = "골드"
            case SILVER = "실버"
            case BRONZE = "브론즈"
            case IRON = "아이언"
            case UNRANKED = "언랭"
        }
        enum rank : String{
            case RANK_ONE = "I"
            case RANK_TWO = "II"
            case RANK_THREE = "III"
            case RANK_FOUR = "IV"
            case UNRANKED = "언랭"
        }
        let leaguePoints : Int32
        let wins : Int32
        let losses : Int32
    }

