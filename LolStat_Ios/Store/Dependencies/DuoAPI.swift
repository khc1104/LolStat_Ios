//
//  DuoAPI.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/3/24.
//

import Foundation
import Dependencies

protocol DuoAPI{
    func requestGetDuoList(page : Int, match: String, queue: String) async throws -> DuoListResponse?
    func requestGetDuoDetail(duoId : Int) async throws -> DuoDetailResponse?
}

class DuoAPIClient: DuoAPI{
    //듀오리스트 get 요청
    func requestGetDuoList(page : Int, match: String, queue: String) async throws -> DuoListResponse?{
        let successRange = 200 ..< 300
        let url = URL(string: "\(Const.Server.ADDRESS)/duo?page=\(page)&match=\(match)&queue=\(queue)")!
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        if let accessToken = KeyChain.read(key: Token.ACCESS_TOKEN.rawValue){
            let authHeader = "Bearer \(accessToken)"
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for : request)
            
            if let httpResponse = response as? HTTPURLResponse{
                if successRange.contains(httpResponse.statusCode){
                    let duoList = try JSONDecoder().decode(DuoListResponse.self, from: data)
                    print(duoList)
                    return duoList
                }else{
                    //print("data - \(String(data: data, encoding: .utf8))")
                    let errorRepsonse = try JSONDecoder().decode(AuthResponse.self, from: data)
                    let returnResposne = DuoListResponse(errorCode: errorRepsonse.errorCode)
                    //let returnResposne = DuoListResponse(errorCode: LolStatError.TOKEN_EXPIRED)
                    return returnResposne
                    
                }
            }else{
                print("requestError - GetDuoList")
                return nil
            }
        }else{
            print("accessToken is nil")
            return nil
        }
    }
    //듀오리스트 post
    
    //듀오디테일 get 요청
    func requestGetDuoDetail(duoId : Int) async throws -> DuoDetailResponse?{
        let successRange = 200 ..< 300
        let url = URL(string: "\(Const.Server.ADDRESS)/duo/\(duoId)")!
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        if let accessToken = KeyChain.read(key: Token.ACCESS_TOKEN.rawValue){
            let authHeader = "Bearer \(accessToken)"
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
            let(data, response) = try await URLSession.shared.data(for:request)
            
            if let httpResponse = response as? HTTPURLResponse{
                if successRange.contains(httpResponse.statusCode){
                    let duoDetail = try JSONDecoder().decode(DuoDetailResponse.self, from:data)
                    return duoDetail
                }else{
                    let errorResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                    let returnResponse = DuoDetailResponse(errorCode: errorResponse.errorCode)
                    return returnResponse
                }
            }else{
                print("requestError - GetDuoDetail")
                return nil
            }
        }else{
            print("accessToken is nil")
            return nil
        }
    }
}

private enum DuoAPIClientKey: DependencyKey{
    static var liveValue: DuoAPI = DuoAPIClient()
}
extension DependencyValues{
    var DuoAPIClient: DuoAPI{
        get { self[DuoAPIClientKey.self]}
        set { self[DuoAPIClientKey.self] = newValue}
    }
}