//
//  LoginEmailInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/22/24.
//

import Foundation
import SwiftUI

struct LoginEmailInput:View {
    @Binding var email: String
    @Binding var isAnimation : Bool
    var body: some View {
        ZStack(alignment: .leading){
            TextField("", text: $email)
                .textFieldStyle(.roundedBorder)
            Text("이메일")
                .padding()
                .offset(
                    //x: -Const.Screen.WIDTH/2.5 ,
                    y: isAnimation ? -30:0)
            
        }
        .frame(width: Const.Screen.WIDTH * 0.8)
    }
}
