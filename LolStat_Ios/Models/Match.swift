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



struct SimpleParticipant : Codable, Equatable, Identifiable {
    var id: String { summonerId }
    
    let summonerId: String
    let summonerName : String
    let summonerLevel : Int32
    let championLevel : Int32
    let kills : Int32
    let deaths : Int32
    let assists : Int32
    let goldEarned : Int32
    let goldSpent : Int32
    //let lane : String
    //let role : String
    let teamId: Int32
    let items : [Item]
    let spells: [Spell]
    let champion : Champion
    let mainRune : Rune
    let subRune : Rune
    let win : Bool
}
    
struct Champion : Codable, Equatable, Hashable {
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


//모스트 챔피언 저장을 위한 모델
struct MostChampion : Equatable{
    let champion : Champion
    var count : Int
    //var order : Int
    var kda : Float
    var winrate : Float
}
