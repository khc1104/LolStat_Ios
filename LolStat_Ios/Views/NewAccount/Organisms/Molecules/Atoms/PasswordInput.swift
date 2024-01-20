//
//  PasswordInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/20/24.
//

import Foundation
import SwiftUI

struct PasswordInput:View {
    @Binding var password : String
    @Binding var isAnimation: Bool
    var body: some View {
        ZStack{
            SecureField("", text: $password)
            Text("비밀번호")
                .offset(y:isAnimation ? -100 : 0)
        }
        
    }
}
