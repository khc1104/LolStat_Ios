//
//  AccountAPI.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/21/24.
//

import Foundation
import Dependencies

protocol AccountAPI{
    func requestCreateUser(user : CreateUserRequest) async throws -> AuthResponse?
    func requestLogin(user :LoginRequest) async throws -> UserInfoDto?
    func requestLoginUserTest() async throws -> UserInfoDto?
    func requestAuthTest() async throws -> AuthResponse?
    func requestRefreshToken() async throws ->AuthResponse?
    func requestUserVerify(code: UserVerifyRequest) async throws -> AuthResponse?
}

class AccountAPIClient: AccountAPI{
    //로그인 요청
    func requestLogin(user : LoginRequest) async throws -> UserInfoDto? {
        let successRange = 200 ..< 300
        let url = URL(string: "\(Const.Server.ADDRESS)/user/login")!
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(user)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse{
            if successRange.contains(httpResponse.statusCode){
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                KeyChain.create(key: Token.REFRESH_TOKEN.rawValue, token: loginResponse.refreshToken)
                KeyChain.create(key: Token.ACCESS_TOKEN.rawValue, token: loginResponse.accessToken)
                
                return loginResponse.userInfo
            }else{
                let test = String(data:data, encoding: .utf8)
                print(test)
                return nil
            }
        }else{
            print("request Error - Login/Test")
            return nil
        }
    }
    //로그인 테스트용 요청 - 액세스토큰 1분 리프레쉬토큰 2분
    func requestLoginUserTest() async throws -> UserInfoDto? {
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
                KeyChain.create(key: Token.REFRESH_TOKEN.rawValue, token: loginResponse.refreshToken)
                KeyChain.create(key: Token.ACCESS_TOKEN.rawValue, token: loginResponse.accessToken)
                
                return loginResponse.userInfo
            }else{
                print("계정이나 비번 틀림")
                return nil
            }
        }else{
            print("request Error - Login/Test")
            return nil
        }
    }
    //회원가입 요청
    func requestCreateUser(user: CreateUserRequest) async throws -> AuthResponse? {
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
                return AuthResponse(errorCode: LolStatError.NO_ERROR, httpStatus: "", message: "")
            }else{
                let responseData = try JSONDecoder().decode(AuthResponse.self, from: data)
                return responseData
            }
        }else{
            print("request error - createUser")
            return nil
        }
    }
    
    //액세스토큰 인증 요청-테스트
    func requestAuthTest() async throws ->  AuthResponse?{
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
                    return AuthResponse(errorCode: LolStatError.NO_ERROR, httpStatus: "", message: "")
                }else{
                    let responseData = try JSONDecoder().decode(AuthResponse.self, from: data)
                    return responseData
                }
            }else{
                print("requestEror - AuthTest")
                return nil
            }
        }else{
            print("acessToken is nil")
            return nil
        }
    }
    //액세스토큰 리프레쉬
    func requestRefreshToken() async throws -> AuthResponse? {
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
                    let responseData = try JSONDecoder().decode(RefreshResponse.self, from: data)
                    KeyChain.create(key: Token.ACCESS_TOKEN.rawValue, token: responseData.accessToken)
                    
                    return AuthResponse(errorCode: LolStatError.NO_ERROR, httpStatus: "", message: "")
                }else{
                    print("data - \(String(data: data, encoding: .utf8) ?? "nil")")
                    let responseData = try JSONDecoder().decode(AuthResponse.self, from: data)
                    return responseData
                }
            }else{
                print("reqeustError - refreshToken")
                return nil
            }
        }else{
            print("RefreshToken is nil")
            return nil
        }
    }
    //이메일 인증요청
    func requestUserVerify(code: UserVerifyRequest) async throws -> AuthResponse?{
        let successRange = 200 ..< 300
        let url = URL(string: "\(Const.Server.ADDRESS)/user/verify")!
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(code)
        
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpBody=jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let accessToken = KeyChain.read(key: "AccessToken"){
            let authHeader = "Bearer \(accessToken)"
            request.addValue(authHeader, forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse{
                if successRange.contains(httpResponse.statusCode){
                    return AuthResponse(errorCode: LolStatError.NO_ERROR, httpStatus: "", message: "")
                }else{
                    let responseData = try JSONDecoder().decode(AuthResponse.self, from: data)
                    return responseData
                }
            }else{
                print("request error - userVerify")
                return nil
            }
        }else{
            print("aceessToken is nil")
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
