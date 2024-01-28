//
//  Account.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//
//유저 인증 요청
struct UserVerifyRequest : Codable{
    var verificationCode : String
}


//회원가입 요청 모델
struct CreateUserRequest: Codable{
    var email : String
    var password : String
    var passwordCheck : String
}
//로그인 요청
struct LoginRequest: Codable{
    var email : String
    var password : String
}
//로그인 반환
struct LoginResponse : Codable, Equatable{
    var accessToken : String
    var refreshToken : String
    var userInfo : UserInfoDto
}
//유저 정보
struct UserInfoDto : Codable, Equatable{
    var userId : Int64
    var email : String
    var verified : Bool
}
//인증 반환
struct AuthResponse : Codable, Equatable{
    var errorCode : Int
    var httpStatus: String
    var message : String
}
//토큰 리프레쉬 반환
struct RefreshResponse: Codable, Equatable{
    var accessToken : String
}
