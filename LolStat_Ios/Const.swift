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
        static let ADDRESS : String = "http://api.lolstat.net"
    }
    
    struct Screen{
        static let WIDTH:CGFloat = UIScreen.main.bounds.width //스크린 가로 길이
        static let HEIGHT:CGFloat = UIScreen.main.bounds.height //스크린 세로길이
    }
    
}
