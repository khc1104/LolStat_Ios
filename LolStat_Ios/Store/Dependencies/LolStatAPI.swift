//
//  LolStatAPI.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/18/23.
//

import Foundation
import Dependencies

protocol LolStatAPI{
    func requestSummonerInfoAPI(summonerName : String) async throws -> Summoner?
    func requestSummonerInfoAPI(summonerId : String) async throws -> Summoner?
    func requestSummonerInfoAPI(puuid: String) async throws -> Summoner?
    func requestMatchsAPI(puuid: String, page: Int32) async throws -> [SimpleMatch]?
    func requestLeaderBoardAPI(page: Int32, queue: LolStatAPIClient.QueueType) async throws -> LeaderBoard?
}

class LolStatAPIClient: LolStatAPI{
    //소환사 정보 요청 - 소환사이름으로 요청
    func requestSummonerInfoAPI(summonerName: String) async throws -> Summoner? {
        let successRange = 200..<300
        let (data, response) = try await URLSession.shared
            .data(from:URL(string: "\(Const.Server.ADDRESS)/summoner/\(summonerName)")!)
        
        if let httpResponse = response as? HTTPURLResponse{
            guard successRange.contains(httpResponse.statusCode)else{
                print("error \(httpResponse.statusCode)")
                print(httpResponse.url!)
                return nil
            }
            let summonerInfo = try JSONDecoder().decode(Summoner.self, from: data)
            return summonerInfo
        }else{
            print("response error - summonerInfo")
            return nil
        }
    }
    //소환사 정보 요청 - 소환사ID로 요청
    func requestSummonerInfoAPI(summonerId: String) async throws -> Summoner?{
        let successRange = 200..<300
        let (data, response) = try await URLSession.shared
            .data(from:URL(string: "\(Const.Server.ADDRESS)/summoner/summonerId/\(summonerId)")!)
        
        if let httpResponse = response as? HTTPURLResponse{
            guard successRange.contains(httpResponse.statusCode)else{
                print("error \(httpResponse.statusCode)")
                print(httpResponse.url!)
                return nil
            }
            let summonerInfo = try JSONDecoder().decode(Summoner.self, from: data)
            return summonerInfo
        }else{
            print("response error - summonerInfo")
            return nil
        }
    }
    
    //소환사 정보 요청 - puuid로 요청
    func requestSummonerInfoAPI(puuid: String) async throws -> Summoner?{
        let successRange = 200..<300
        let (data, response) = try await URLSession.shared
            .data(from:URL(string: "\(Const.Server.ADDRESS)/summoner/puuid/\(puuid)")!)
        
        if let httpResponse = response as? HTTPURLResponse{
            guard successRange.contains(httpResponse.statusCode)else{
                print("error \(httpResponse.statusCode)")
                print(httpResponse.url!)
                return nil
            }
            let summonerInfo = try JSONDecoder().decode(Summoner.self, from: data)
            return summonerInfo
        }else{
            print("response error - summonerInfo")
            return nil
        }
    }

    //매치 정보 요청
    func requestMatchsAPI(puuid: String, page: Int32) async throws -> [SimpleMatch]? {
        let successRange = 200..<300
        let (data, response) = try await URLSession.shared
            .data(from:URL(string: "\(Const.Server.ADDRESS)/matches/\(puuid)?page=\(page)")!)
        
        if let httpResponse = response as? HTTPURLResponse{
            guard successRange.contains(httpResponse.statusCode)else{
                print("error \(httpResponse.statusCode)")
                print(httpResponse.url!)
                return nil
            }
            let matches = try JSONDecoder().decode([SimpleMatch].self, from: data)
            return matches
        }else{
            print("response error - match")
            return nil
        }
    }
    
    //리더보드 요청
    func requestLeaderBoardAPI(page: Int32, queue: LolStatAPIClient.QueueType) async throws -> LeaderBoard?{
        let successRange = 200..<300
        let  (data, response) = try await URLSession.shared
            .data(from:URL(string:"\(Const.Server.ADDRESS)/leaderboard?page=\(page)&queue=\(queue.rawValue)")!)
        
        if let httpResponse = response as? HTTPURLResponse{
            guard successRange.contains(httpResponse.statusCode)else{
                print("error \(httpResponse.statusCode)")
                print(httpResponse.url!)
                return nil
            }
            let leaderBoard = try JSONDecoder().decode(LeaderBoard.self, from: data)
            return leaderBoard
        }else{
            print("response error - leaderBoard")
            return nil
        }
    }
    
    enum QueueType: String{
        case RANKED_SOLO = "RANKED_SOLO_5x5"
        case RANKED_FLEX = "RANKED_FLEX_SR"
    }
}

private enum LolStatAPIClientKey: DependencyKey{
    static var liveValue: LolStatAPI = LolStatAPIClient()
}

extension DependencyValues{
    var lolStatAPIClient: LolStatAPI{
        get { self[LolStatAPIClientKey.self]}
        set { self[LolStatAPIClientKey.self] = newValue}
    }
}
