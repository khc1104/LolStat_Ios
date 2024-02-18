//
//  DuoSelectPosition.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoSelectPosition: View {
    var position : Line
    var isSelect : Bool = false
    var size : CGFloat = 40
    var body: some View {
        ZStack{
            Image(position.image()).resizable()
        }
        .frame(width: size, height: size)
        .background(isSelect ? .mint : .secondary)
    }
}
