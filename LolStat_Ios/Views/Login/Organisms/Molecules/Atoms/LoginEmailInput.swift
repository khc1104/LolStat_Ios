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
    //@Binding var isAnimation : Bool
    var body: some View {
        ZStack(alignment: .leading){
            TextField("이메일", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
            
        }
        .frame(width: Const.Screen.WIDTH * 0.8)
    }
}
