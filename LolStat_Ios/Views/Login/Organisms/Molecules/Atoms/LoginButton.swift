//
//  GoLoginButton.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/22/24.
//

import Foundation
import SwiftUI

struct LoginButton : View {
    var body: some View {
        Button{
            
        }label: {
            Text("로그인")
                .padding(.vertical, 8)
                .frame(width: Const.Screen.WIDTH * 0.8)
                .background(.winBlue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct privew_Loginbutton : PreviewProvider{
    static var previews: some View{
        LoginButton()
    }
    
}
