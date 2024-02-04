//
//  DuoMainPosition.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/31/24.
//

import Foundation
import SwiftUI

struct DuoPosition : View {
    var positions : [Line]
    var width: CGFloat = 40
    var height: CGFloat = 40
    var body: some View {
        VStack{
            ForEach(positions, id: \.self){position in
                Image(position.image()).resizable()
                    .frame(width: width, height: height)
            }
        }
    }
}
