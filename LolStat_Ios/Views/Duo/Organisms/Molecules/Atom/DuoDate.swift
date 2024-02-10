//
//  DuoExpDate.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/2/24.
//

import Foundation
import SwiftUI

struct DuoDate: View {
    let date : String
    var body: some View {
        HStack{
            Text(getDate(datetime: date))
            Text(getTime(datetime: date))
        }
    }
}

func getDate(datetime : String) -> String{
    let arr = datetime.split(separator: "T")
    let date = arr[0]
    let monthDay = date.split(separator: "-")
    return "\(monthDay[1])-\(monthDay[2])"
}

func getTime(datetime : String) -> String{
    let arr = datetime.split(separator: "T")
    let time = String(arr[1])
    let time2 = time.split(separator: ":")
    
    return "\(time2[0]):\(time2[1])"
}
