//
//  AccountAPI.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/21/24.
//

import Foundation
import Dependencies

protocol AccountAPI{
    func requestCreateUser(user : CreateUserRequest) async throws -> Bool
    func requestLoginUserTest() async throws -> LoginResponse?
}

class AccountAPIClient: AccountAPI{
    func requestLoginUserTest() async throws -> LoginResponse? {
        let successRange = 200 ..< 300
        let url = URL(string: "\(Const.Server.ADDRESS)/user/login/test")!
        let decoder = JSONDecoder()
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse{
            if successRange.contains(httpResponse.statusCode){
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                return loginResponse
            }else{
                print("LoginTest Error - \(httpResponse.statusCode)")
                return nil
            }
        }else{
            print("request Error - Login/Test")
            return nil
        }
    }
    
    func requestCreateUser(user: CreateUserRequest) async throws -> Bool {
        let successRange = 200 ..< 300
        let url = URL(string:"\(Const.Server.ADDRESS)/user")!
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(user)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (_, response) = try await URLSession.shared.data(for: request)
    
        if let httpResponse = response as? HTTPURLResponse{
            if successRange.contains(httpResponse.statusCode){
                return true
            }else{
                print("createUser Error - \(httpResponse.statusCode)")
                return false
            }
        }else{
            print("request error - createUser")
            return false
        }
    }
    
    
}

private enum AccountAPIClientKey: DependencyKey{
    static var liveValue: AccountAPI = AccountAPIClient()
}

extension DependencyValues{
    var accountAPIClient: AccountAPI{
        get { self[AccountAPIClientKey.self]}
        set { self[AccountAPIClientKey.self] = newValue}
    }
}
