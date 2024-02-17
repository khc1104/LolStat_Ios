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
    var errorCode : LolStatError
    
    private enum CodingKeys : String, CodingKey{
        case userId
        case email
        case verified
        case errorCode
    }
    
    init(errorCode : LolStatError){
        self.userId = 0
        self.email = ""
        self.verified = false
        self.errorCode = errorCode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decodeIfPresent(Int64.self, forKey: .userId) ?? 0
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.verified = try container.decodeIfPresent(Bool.self, forKey: .verified) ?? false
        self.errorCode = try container.decodeIfPresent(LolStatError.self, forKey: .errorCode) ?? LolStatError.NO_ERROR
    }
}
//인증 반환
struct AuthResponse : Codable, Equatable{
    var errorCode : LolStatError
    var httpStatus: String
    var message : String
}
//토큰 리프레쉬 반환
struct RefreshResponse: Codable, Equatable{
    var accessToken : String
}

