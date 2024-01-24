//
//  GoJoinButton.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/22/24.
//

import Foundation
import SwiftUI

struct GoJoinButton: View {
    var body: some View {
        Button{
            
        }label: {
            Text("회원가입")
                .padding(.vertical, 8)
                .frame(width: Const.Screen.WIDTH * 0.8)
                .background(.secondary)
                .foregroundColor(.black)
                .cornerRadius(8)
        }
    }
}
