//
//  Account.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/11.
//

import Foundation

// User - Model

struct Account{
    struct AccountDto{
        private var puuid : String
        private var gameName : String
        private var tagLine : String
        
        
        public init(puuid : String, gameName : String, tagLine: String){
            self.puuid = puuid
            self.gameName = gameName
            self.tagLine = tagLine
        }
    }
}
