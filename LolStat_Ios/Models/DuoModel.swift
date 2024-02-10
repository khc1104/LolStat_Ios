//
//  Duo.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/31/24.
//

import Foundation

struct AddDuoRequest : Codable{
    var gameName : String
    var tagLine : String
    var lines : Line
    var wishLines : Line
    var wishTiers : Tier
    var duoQueueId : DuoQueueId
    var memo : String
}

struct DuoListResponse : Codable{
    /*var id :Int64
    var userId : Int64
    var gameName : String
    var tagLine : String
    var puuid : String
    var lines : Line
    var tier : Tier
    var wishLines : Line
    var wishTiers : [Tier]
    var createdAt : String
    var expiredAt : String
    var tickets : [DuoTicketDto]
    var duoQueueId : String
    var recentMatched : [DuoRecentMatchDto]
    var memo : String
    var matched : Bool
     */
    var myDuo : DuoDto?
    var duoList : [DuoDto]?
    var errorCode : LolStatError
    
    private enum CodingKeys : String, CodingKey{
        case myDuo
        case duoList
        case errorCode
    }
    
    init(errorCode : LolStatError){
        self.errorCode = errorCode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.myDuo = try container.decodeIfPresent(DuoDto.self, forKey: .myDuo)
        self.duoList = try container.decodeIfPresent([DuoDto].self, forKey: .duoList)
        self.errorCode = try container.decodeIfPresent(LolStatError.self, forKey: .errorCode) ?? LolStatError.NO_ERROR
    }
    
     
    
}

struct DuoDto: Codable, Equatable, Identifiable{
    var id : Int64
    var userId : Int64
    var gameName : String
    var tagLine : String
    var puuid : String
    var lines : [Line]
    var tier : Tier
    var wishLines : [Line]
    var wishTiers : [Tier]
    var createdAt : String
    var expiredAt : String
    var tickets : [DuoTicketDto]
    var duoQueueId : DuoQueueId
    var recentMatches : [DuoRecentMatchDto]
    var memo : String
    var matched : Bool
}

struct DuoRecentMatchDto : Codable, Equatable{
    var championDto : Champion
    var kills : Int32
    var deaths : Int32
    var assists : Int32
    var win : Bool
}

struct DuoTicketDto : Codable, Equatable, Identifiable{
    var id :Int64
    var userId : Int64
    var duoId : Int64
    var gameName : String
    var tagLine : String
    var lines : [Line]
    var tier : Tier
    var memo : String
    var createdAt : String
    var recentMatches : [DuoRecentMatchDto]
    var puuid : String?
}

struct DuoDetailResponse: Codable, Equatable{
    var duo : DuoDto?
    var errorCode : LolStatError
    
    private enum CodingKeys : String, CodingKey{
        case duo
        case errorCode
    }
    
    init(errorCode : LolStatError){
        self.errorCode = errorCode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.duo = try container.decodeIfPresent(DuoDto.self, forKey: .duo)
        self.errorCode = try container.decodeIfPresent(LolStatError.self, forKey: .errorCode) ?? LolStatError.NO_ERROR
    }
}

struct MyDuoResponse : Codable, Equatable{
    var myDuo : DuoDto
}
