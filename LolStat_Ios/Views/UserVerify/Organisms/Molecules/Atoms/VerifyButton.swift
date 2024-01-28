//
//  VerifyButton.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/28/24.
//

import Foundation
import SwiftUI

struct VerifyButton:View {
    var body: some View {
        GeometryReader{ geo in
            Button{
                
            }label: {
                Text("인증")
                    .padding()
                    .frame(width: geo.size.width)
                    .background(.secondary)
                    .cornerRadius(8)
                    
            }
        }
    }
}

struct VerifyButtonPreview: PreviewProvider{
    static var previews: some View{
        VerifyButton()
    }
}
