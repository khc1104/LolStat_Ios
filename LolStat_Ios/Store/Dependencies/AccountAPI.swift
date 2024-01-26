//
//  AccountAPI.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/21/24.
//

import Foundation
import Dependencies

protocol AccountAPI{
    func requestCreateUser(user : CreateUserRequest) async throws -> Int
    func requestLoginUserTest() async throws -> LoginResponse?
    func requestAuthTest() async throws -> Int?
    func requestRefreshToken() async throws ->String?
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
    func requestCreateUser(user: CreateUserRequest) async throws -> Int {
        let successRange = 200 ..< 300
        let url = URL(string:"\(Const.Server.ADDRESS)/user")!
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(user)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
    
        if let httpResponse = response as? HTTPURLResponse{
            if successRange.contains(httpResponse.statusCode){
                return 200
            }else{
                print("createUser Error - \(httpResponse.statusCode)")
                //print("data - \(String(data: data, encoding: .utf8))")
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                return authResponse.errorCode
            }
        }else{
            print("request error - createUser")
            return 400
        }
    }
    
    //액세스토큰 인증 요청-테스트
    func requestAuthTest() async throws ->  Int?{
        let successRange = 200 ..< 300
        let url = URL(string:"\(Const.Server.ADDRESS)/user/auth/test")!
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        if let accessToken = KeyChain.read(key: "AccessToken"){
            let authHeader = "Bearer \(accessToken)"
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse{
                if successRange.contains(httpResponse.statusCode){
                    //print("success to auth-\(httpResponse.statusCode)")
                    
                    return 200
                }else{
                    print("failed to auth - \(httpResponse.statusCode)")
                    print("data - \(String(data: data, encoding: .utf8) ?? "nil")")
                    let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                    return authResponse.errorCode
                }
            }else{
                print("data - \(data)")
                return nil
            }
        }else{
            print("acessToken is nil")
            return nil
        }
    }
    //액세스토큰 리프레쉬
    func requestRefreshToken() async throws -> String? {
        let successRange = 200..<300
        let url = URL(string: "\(Const.Server.ADDRESS)/user/refresh")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        if let refreshToken = KeyChain.read(key: "RefreshToken"){
            let authHeader = "Bearer \(refreshToken)"
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse{
                if successRange.contains(httpResponse.statusCode){
                    let accessToken = try JSONDecoder().decode(RefreshResponse.self, from: data)
                    
                    return accessToken.accessToken
                }else{
                    print("data - \(String(data: data, encoding: .utf8) ?? "nil")")
                    let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                    
                    return "\(authResponse.errorCode)"
                }
            }else{
                print("requestRefreshToken is failed")
                return nil
            }
        }else{
            print("RefreshToken is nil")
            return nil
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
