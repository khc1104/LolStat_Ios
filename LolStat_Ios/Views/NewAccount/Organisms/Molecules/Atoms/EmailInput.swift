//
//  VerifyEmail.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/19/24.
//

import Foundation
import SwiftUI

struct EmailInput : View {
    @Binding var email : String
    @Binding var isAnimation: Bool
    var body: some View {
        ZStack{
            TextField("", text: $email)
            Text("이메일")
                .offset(y:isAnimation ? -40 : 0)
        }
        
    }
}
