//
//  Summoner.swift
//  valorant_project
//
//  Created by 권희철 on 2023/11/02.
//

import Foundation

struct Summoner : Codable, Equatable {
    let profile : Profile
    let matches : [SimpleMatch]
}
