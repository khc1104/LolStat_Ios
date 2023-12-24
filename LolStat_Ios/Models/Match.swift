//
//  Match.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//



struct SimpleMatch : Codable, Equatable, Identifiable {
    var id : String { matchId }
    
    let matchId : String
    let gameMode : GameMode
    let gameType : GameType
    let queueId : QueueId
    let participants : [SimpleParticipant]
    
}

enum GameMode : String, Codable{
    case CLASSIC = "CLASSIC"
    case ODIN = "ODIN"
    case ARAM = "ARAM"
    case TUTORIAL = "TUTORIAL"
    case URF = "URF"
    case DOOMBOTSTEEMO = "DOOMBOTSTEEMO"
    case ONEFORALL = "ONEFORALL"
    case ASCENSION = "ASCENSION"
    case FIRSTBLOOD = "FIRSTBLOOD"
    case KINGPORO = "KINGPORO"
    case SIEGE = "SIEGE"
    case ASSASSINATE = "ASSASSINATE"
    case ARSR = "ARSR"
    case DARKSTAR = "DARKSTAR"
    case STARGUARDIAN = "STARGUARDIAN"
    case PROJECT = "PROJECT"
    case GAMEMODEX = "GAMEMODEX"
    case ODYSSEY = "ODYSSEY"
    case NEXUSBLITZ = "NEXUSBLITZ"
    case ULTBOOK = "ULTBOOK"
    case UNKNOWN = "UNKNOWN"
    
    func description() -> String{
        switch self{
        case .CLASSIC:
            return "소환사의 협곡"
        case .ODIN:
            return "ODIN"
        case .ARAM:
            return "칼바람 나락"
        case .TUTORIAL:
            return "튜토리얼"
        case .URF:
            return "우르프"
        case .DOOMBOTSTEEMO:
            return "초토화 봇"
        case .ONEFORALL:
            return "단일 챔피언"
        case .ASCENSION:
            return "초월"
        case .FIRSTBLOOD:
            return "헥사킬"
        case .KINGPORO:
            return "포로왕"
        case .SIEGE:
            return "넥서스 공성전"
        case .ASSASSINATE:
            return "ASSASSINATE"
        case .ARSR:
            return "무작위 총력전"
        case .DARKSTAR:
            return "암흑의 별"
        case .STARGUARDIAN:
            return "별수호자"
        case .PROJECT:
            return "프로젝트: 과충전 모드"
        case .GAMEMODEX:
            return "GAMEMODEX"
        case .ODYSSEY:
            return "오디세이: 구출"
        case .NEXUSBLITZ:
            return "돌격! 넥서스"
        case .ULTBOOK:
            return "궁극기 주문서"
        case .UNKNOWN:
            return "기타"
        }
    }
    
    init(from decoder: Decoder) throws{
        self = try GameMode(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .UNKNOWN
    }
}
enum GameType : String, Codable{
    case CUSTOM_GAME = "CUSTOM_GAME"
    case TUTORIAL_GAME = "TUTORIAL_GAME"
    case MATCHED_GAME = "MATCHED_GAME"
    
    func description() -> String{
        switch self{
        case .CUSTOM_GAME:
            return "사용자 설정 게임"
        case .TUTORIAL_GAME:
            return "튜토리얼"
        case .MATCHED_GAME:
            return "매칭"
        }
    }
}
enum QueueId : String, Codable{
    case CUSTOM_GAME = "CUSTOM_GAME"
    case URF_GAME = "URF_GAME"
    case DRAFT_GAME = "DRAFT_GAME"
    case DYNAMIC_RANK_GAME = "DYNAMIC_RANK_GAME"
    case FLEX_RANK_GAME  = "FLEX_RANK_GAME"
    case SOLO_RANK_GAME = "SOLO_RANK_GAME"
    case NORMAL_GAME = "NORMAL_GAME"
    case OTHER_GAME = "OTHER_GAME"
    
    func description() -> String{
        switch self{
        case .CUSTOM_GAME:
            return "사용자 설정 게임"
        case .URF_GAME:
            return "우르프"
        case .DRAFT_GAME:
            return "교차선택"
        case .DYNAMIC_RANK_GAME, .FLEX_RANK_GAME:
            return "자유 랭크"
        case .SOLO_RANK_GAME:
            return "솔로/듀오 랭크"
        case .NORMAL_GAME:
            return "일반 게임"
        case .OTHER_GAME:
            return "기타"
        }
    }
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
    let items : [Item]
    let spells: [Spell]
    let champion : Champion
    let win : Bool
    let mainRune : Rune
    let subRune : Rune
}
    
struct Champion : Codable, Equatable {
    let name : String?
    let description : String?
    let image : String
}
    
struct Item : Codable, Equatable{
    var name : String?
    let plaintext : String?
    let image : String
}
    
struct Rune : Codable, Equatable{
    let name : String?
    let description : String?
    let image : String
}
    
struct Spell : Codable, Equatable{
    let name : String
    let description : String
    let image : String
}

