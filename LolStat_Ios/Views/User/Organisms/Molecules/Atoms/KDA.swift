//
//  KDA.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct KDA : View {
    var kill : Int
    var death : Int
    var assist : Int
    
    var body: some View {
        HStack(spacing: 2){
            Text(String(kill))
            Text("/")
            Text(String(death))
                .foregroundStyle(.red)
            Text("/")
            Text(String(assist))
        }
    }
}
