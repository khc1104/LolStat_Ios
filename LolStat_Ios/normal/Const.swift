//
//  Const.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/08.
//

import Foundation
import SwiftUI

struct Const{
    struct Server{
        static let ADDRESS : String = "https://api.lolstat.net"
        static let IMGAGE_ADDRESS: String = "https://lolstat.net"
    }
    
    struct Screen{
        static let WIDTH:CGFloat = UIScreen.main.bounds.width //스크린 가로 길이
        static let HEIGHT:CGFloat = UIScreen.main.bounds.height //스크린 세로길이
    }
    
}

enum LeaderBoard_QueueType: String{
    case Solo = "solo_rank"
    case Flex = "felx_rank"
}

enum LolStatError: Int, Codable{
    case USER_JOIN_FAIL = 1000
    case USER_LOGIN_FAIL = 1001
    case NEED_LOGIN = 1002
    case NEED_EMAIL_AUTHENTICATION = 1003
    case WRONG_EMAIL_AUTHENTICATION = 1004
    case TOKEN_EXPIRED = 1005
    case DUO_ALREADY_EXIST = 2000
    case DUO_EXPIRED = 2001
    case DUO_ALREADY_MATCHED = 2002
    case DUO_OWNER_TRY_TICKET = 2003
    case INPUT_ERROR = 9000
    case NO_ERROR = 200
}
