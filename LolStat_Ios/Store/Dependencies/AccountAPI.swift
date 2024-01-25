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
    func requestAuthTest() async throws -> Bool
}

class AccountAPIClient: AccountAPI{
    //로그인 테스트용 요청 - 액세스토큰 1분 리프레쉬토큰 2분
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
    //회원가입 요청(스테이터스 코드로 에러 핸들링 필요)
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
    
    //액세스토큰 인증 요청-테스트
    func requestAuthTest() async throws -> Bool {
        let successRange = 200 ..< 300
        let url = URL(string:"\(Const.Server.ADDRESS)/user/auth/test")!
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        if let accessToken = KeyChain.read(key: "AccessToken"){
            let authHeader = "Bearer \(accessToken)"
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
            print("request header")
            print(request.value(forHTTPHeaderField: "Authorization") ?? "auth")
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse{
                if successRange.contains(httpResponse.statusCode){
                    print("success to auth-\(httpResponse.statusCode)")
                    return true
                }else{
                    print("failed to auth - \(httpResponse.statusCode)")
                    print("data - \(String(data: data, encoding: .utf8) ?? "nil")")
                    print("response - \(response)")
                    return false
                }
            }else{
                print("data - \(data)")
                return false
            }
        }else{
            print("acessToken is nil")
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
