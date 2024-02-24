//
//  VerifyTimer.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/28/24.
//

import Foundation
import SwiftUI

struct VerifyTimer: View {
    var timer : Int = 0
    var body: some View {
            Text("\(timeString(timer))")
        
    }
}

func timeString(_ time: Int) -> String{
    let minutes = time / 60
    let seconds = time % 60
    return String("\(minutes) : \(seconds)")
}



struct previewVerify : PreviewProvider{
    static var previews: some View{
        VerifyTimer()
    }
}

