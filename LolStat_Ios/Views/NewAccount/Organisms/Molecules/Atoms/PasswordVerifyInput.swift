//
//  PasswordVerifyInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/20/24.
//

import Foundation
import SwiftUI

struct PasswordVerifyInput:View {
    @Binding var passwordVerify : String
    @Binding var isAnimation: Bool
    var body: some View {
        
        ZStack{
            SecureField("", text: $passwordVerify)
            Text("비밀번호 확인")
                .offset(y:isAnimation ? -40 : 0)
        }
        
    }
}
