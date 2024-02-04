//
//  DuoExpDate.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/2/24.
//

import Foundation
import SwiftUI

struct DuoExpDate: View {
    let date : String
    var body: some View {
        VStack{
            Text(getDate(date: date))
            Text(getTime(date: date))
        }
    }
}

func getDate(date : String) -> String{
    let arr = date.split(separator: "T")
    return String(arr[0])
}

func getTime(date : String) -> String{
    let arr = date.split(separator: "T")
    let time1 = String(arr[1])
    let time2 = time1.split(separator: ".")
    return String(time2[0])
}
