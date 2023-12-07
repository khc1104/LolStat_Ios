//
//  Account.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//

struct ErrorResponse: Codable, Equatable{
    var timestamp : String
    var status : Int
    var error : String
    var path : String
}
