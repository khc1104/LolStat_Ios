//
//  KDA.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct KDA : View {
    var kill : Int32
    var death : Int32
    var assist : Int32
    
    var body: some View {
        HStack(spacing: 2){
            Text(String(kill))
            Text("/")
                .foregroundStyle(.secondary)
            Text(String(death))
                .foregroundStyle(.red)
            Text("/")
                .foregroundStyle(.secondary)
            Text(String(assist))
        }
    }
}
