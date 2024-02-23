//
//  LoginPasswordInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/22/24.
//

import Foundation
import SwiftUI

struct LoginPasswordInput:View {
    @Binding var password : String
    //@Binding var isAnimation : Bool
    var body: some View {
        ZStack(alignment: .leading){
            SecureField("비밀번호", text: $password)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
        }
        .frame(width: Const.Screen.WIDTH * 0.8)
    }
}
