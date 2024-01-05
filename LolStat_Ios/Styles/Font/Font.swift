//
//  Font.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/5/24.
//

import Foundation
import SwiftUI

extension Font{
    enum KingSejong{
        case regular
        case bold
        case custom(String)
        
        var value: String{
            switch self{
            case .regular:
                return "KingSejongInstitute-Regular"
            case .bold:
                return "KingSejongInstitute-Bold"
            case .custom(let name):
                return name
            }
        }
    }
    
    static func kingSejong(_ type: KingSejong, size: CGFloat = 12)-> Font{
        return .custom(type.value, size: size)
    }
}
