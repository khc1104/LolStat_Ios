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
        Text(transDate(date : date))
    }
}

func transDate(date : String) -> String{
    
    guard let isoDate = ISO8601DateFormatter().date(from: date) else{return "date"}
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
    let dateString = dateFormatter.string(from: isoDate)
    return dateString
    
}
