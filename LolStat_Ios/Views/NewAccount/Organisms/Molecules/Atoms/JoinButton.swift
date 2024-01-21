//
//  JoinButton.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/21/24.
//

import Foundation
import SwiftUI

struct JoinButton:View {
    var disable : Bool
    var body: some View {
        ZStack(alignment:.topLeading){
            Text("회원 가입")
        }
        .background(Rectangle().fill(disable ? .black : .secondary))
        //.frame(width: Const.Screen.WIDTH)
        .frame(width: 500)
        .foregroundStyle(disable ? .gray : .white)
    }
}
