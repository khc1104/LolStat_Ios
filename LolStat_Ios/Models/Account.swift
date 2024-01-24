//
//  Account.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//

struct UserVerifyRequest : Codable{
    var verificationCode : String
}


//회원가입 요청 모델
struct CreateUserRequest: Codable{
    var email : String
    var password : String
    var passwordCheck : String
}

struct LoginRequest: Codable{
    var email : String
    var password : String
}

struct LoginResponse : Codable, Equatable{
    var accessToken : String
    var refreshToken : String
    var userInfo : UserInfoDto
}
struct UserInfoDto : Codable, Equatable{
    var userId : Int64
    var email : String
    var verified : Bool
}
