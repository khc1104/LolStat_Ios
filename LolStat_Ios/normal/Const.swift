//
//  Const.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/08.
//

import Foundation
import SwiftUI

struct Const{
    struct Server{
        static let ADDRESS : String = "https://api.lolstat.net"
        static let IMGAGE_ADDRESS: String = "https://lolstat.net"
    }
    
    struct Screen{
        static let WIDTH:CGFloat = UIScreen.main.bounds.width //스크린 가로 길이
        static let HEIGHT:CGFloat = UIScreen.main.bounds.height //스크린 세로길이
    }
    
}
/*
 유저페이지 및 듀오페이지
 */
enum QueueType : String, Codable{ //큐타입
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
enum Tier : String, Codable{ //티어
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
    
    func imageUrl() -> String{ //티어 이미지(현재 사용안함)
        switch self{
        case .CHALLENGER:
            return "/challenger.webp"
        case .GRANDMASTER:
            return "/grandmaster.webp"
        case .MASTER:
            return "/master.webp"
        case .DIAMOND:
            return "/diamond.webp"
        case .EMERALD:
            return "/emerald.webp"
        case .PLATINUM:
            return "/platinum.webp"
        case .GOLD:
            return "/gold.webp"
        case .SILVER:
            return "/silver.webp"
        case .BRONZE:
            return "/bronze.webp"
        case .IRON:
            return "/iron.webp"
        case .UNRANKED:
            return "/unranked.webp"
        }
    }
    func image() -> ImageResource{ //티어 이미지(앱에 저장되어있는 이미지 사용)
        switch self{
        case .CHALLENGER:
            return .challenger
        case .GRANDMASTER:
            return .grandmaster
        case .MASTER:
            return .master
        case .DIAMOND:
            return .diamond
        case .EMERALD:
            return .emerald
        case .PLATINUM:
            return .platinum
        case .GOLD:
            return .gold
        case .SILVER:
            return .silver
        case .BRONZE:
            return .bronze
        case .IRON:
            return .iron
        case .UNRANKED:
            return .unranked
        }
    }
}
enum Rank : String, Codable{ //티어 + 숫자(이거)
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
            return ""
        }
    }
}
/*
 매치페이지
 */
enum GameMode : String, Codable{ //게임모드
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
enum GameType : String, Codable{ //게임타입
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
enum QueueId : String, Codable{ //큐타입
    case CUSTOM_GAME = "CUSTOM_GAME"
    case URF_GAME = "URF_GAME"
    case DRAFT_GAME = "DRAFT_GAME"
    case DYNAMIC_RANK_GAME = "DYNAMIC_RANK_GAME"
    case FLEX_RANK_GAME  = "FLEX_RANK_GAME"
    case SOLO_RANK_GAME = "SOLO_RANK_GAME"
    case NORMAL_GAME = "NORMAL_GAME"
    case QUICK_PLAY = "QUICK_PLAY"
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
        case .QUICK_PLAY:
            return "빠른 대전"
        case .OTHER_GAME:
            return "기타"
        }
    }
    init(from decoder: Decoder) throws{
        self = try QueueId(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .OTHER_GAME
    }
}

/*
 리더보드
 */
enum LeaderBoard_QueueType: String{ //리더보드 큐타입
    case Solo = "solo_rank"
    case Flex = "felx_rank"
}
/*
 듀오페이지
 */
enum Line: String, Codable{ //포지션
    case TOP = "TOP"
    case JG = "JG"
    case MID = "MID"
    case AD = "AD"
    case SUP = "SUP"
    
    func description() -> String{
        switch self{
        case .TOP:
            return "탑"
        case .JG:
            return "정글"
        case .MID:
            return "미드"
        case .AD:
            return "바텀"
        case .SUP:
            return "서포터"
        }
    }
    func image() -> ImageResource{
        switch self{
        case .TOP:
            return .positionTop
        case .JG:
            return .positionJungle
        case .MID:
            return .positionMid
        case .AD:
            return .positionBot
        case .SUP:
            return .positionSupport
        }
    }
}

enum DuoQueueId : String, Codable{
    case SOLO_RANK_GAME = "SOLO_RANK_GAME"
    case FLEX_RANK_GAME = "FLEX_RANK_GAME"
    case QUICK_PLAY = "QUICK_PLAY"
    
    func description() -> String{
        switch self{
        case .SOLO_RANK_GAME:
            return "솔로/듀오 랭크"
        case .FLEX_RANK_GAME:
            return "자유 랭크"
        case .QUICK_PLAY:
            return "빠른 대전"
        }
    }
    
}

/*
 API에러코드
 */
enum LolStatError: Int, Codable{ //에러코드
    case USER_JOIN_FAIL = 1000
    case USER_LOGIN_FAIL = 1001
    case NEED_LOGIN = 1002
    case NEED_EMAIL_AUTHENTICATION = 1003
    case WRONG_EMAIL_AUTHENTICATION = 1004
    case TOKEN_EXPIRED = 1005
    case DUO_ALREADY_EXIST = 2000
    case DUO_EXPIRED = 2001
    case DUO_ALREADY_MATCHED = 2002
    case DUO_OWNER_TRY_TICKET = 2003
    case INPUT_ERROR = 9000
    case NO_ERROR = 200
}
