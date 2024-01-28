//
//  VerifyCodeInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/28/24.
//

import Foundation
import SwiftUI

struct VerifyCodeInput: View {
    @Binding var verifycode : String
    var body: some View {
        TextField("인증번호", text: $verifycode)
            .textFieldStyle(.roundedBorder)
    }
}

/*
struct verifyInputPreview : PreviewProvider{
    static var previews: some View{
        VerifyCodeInput()
    }
}
*/
