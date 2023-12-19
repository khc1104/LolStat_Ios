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
}

class LolStatAPIClient: LolStatAPI{
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
            print("response error")
            return nil
        }
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
