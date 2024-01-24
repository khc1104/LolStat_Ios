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
        Button{
            
        }label: {
            Text("회원가입")
                .padding(.vertical, 10)
                .frame(width: Const.Screen.WIDTH*0.8)
                .background(Rectangle().fill( disable ? .winBlue : .secondary))
                .foregroundStyle(disable ? .gray : .white)
        }
    }
}

struct preview_joinButton : PreviewProvider{
    static var previews: some View{
        JoinButton(disable: false)
    }
}
