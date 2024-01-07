//
//  Summoner.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//


struct Summoner : Codable, Equatable {
    let profile : Profile
    var matches : [SimpleMatch]
}
