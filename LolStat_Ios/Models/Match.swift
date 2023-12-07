//
//  Match.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//


struct SimpleMatch : Codable, Equatable {
    let matchId : String
    enum gameMode : String{
        case CLASSIC = "소환사의 협곡"
        case ODIN = "몰?루Odin"
        case ARAM = "칼바람 나락"
        case TUTORIAL = "튜토리얼"
        case URF = "우르프"
        case DOOMBOTSTEEMO = "초토화 봇 모드"
        case ONEFORALL = "단일 챔피언"
        case ASCENSION = "초월 모드"
        case FIRSTBLOOD = "헥사킬"
        case KINGPORO = "전설의 포로 왕"
        case SIEGE = "넥서스 공성전"
        case ASSASSINATE = "몰?루Assasinate"
        case ARSR = "무작위 총력전"
        case DARKSTAR = "암흑의 별"
        case STARGUARDIAN = "clarhd ahem"
        case PROJECT = "프로젝트 : 과충전 모드"
        case GAMEMODEX = "몰?루gamemodex"
        case ODYSSEY = "오디세이: 구출"
        case NEXUSBLITZ = "돌격! 넥서스"
        case ULTBOOK = "궁극기 주문서"
    }
    enum gameType : String{
        case CUSTOM_GAME = "사용자 설정 게임"
        case TUTORIAL_GAME = "튜토리얼"
        case MATCHED_GAME = "매칭"
    }
    enum queueId : String{
        case CUSTOM_GAME = "사용자 설정 게임"
        case URF_GAME = "우르프 모드"
        case DRAFT_GAME = "교차선택"
        case DYNAMIC_RANK_GAME, FLEX_RANK_GAME  = "자유 랭크"
        case SOLO_RANK_GAME = "솔로/듀오 랭크"
        case NORMAL_GAME = "일반 게임"
        case OTHER_GAME = "기타"
    }
    let participants : [SimpleParticipant]
    
}

struct SimpleParticipant : Codable, Equatable {
        let summonerName : String
        let summonerLevel : Int32
        let championLevel : Int32
        let kills : Int32
        let deaths : Int32
        let assists : Int32
        let lane : String
        let role : String
        let teamId: Int32
        let items : [Item]?
        let spells: [Spell]
        let champion : Champion
        let win : Bool
        let mainRune : Rune
        let subRune : Rune
    }
    
struct Champion : Codable, Equatable {
        let name : String
        let description : String
        let image : String
    }
    
struct Item : Codable, Equatable{
        let name : String?
        let plaintext : String?
        let image : String?
    }
    
struct Rune : Codable, Equatable{
        let name : String?
        let description : String?
        let image : String?
    }
    
struct Spell : Codable, Equatable{
        let name : String?
        let description : String?
        let image : String?
    }

