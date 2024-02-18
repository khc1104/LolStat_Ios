//
//  DuoDetailPostion.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoDetailPosition: View {
    let lines : [Line]
    var size : CGFloat = 40
    var body: some View {
        HStack(spacing: 0){
            DuoSelectPosition(position: Line.TOP, isSelect: lines.contains(Line.TOP), size: size)
            DuoSelectPosition(position: Line.JG, isSelect: lines.contains(Line.JG), size: size)
            DuoSelectPosition(position: Line.MID, isSelect:lines.contains(Line.MID), size: size)
            DuoSelectPosition(position: Line.AD, isSelect:lines.contains(Line.AD), size: size)
            DuoSelectPosition(position: Line.SUP, isSelect:lines.contains(Line.SUP), size: size)
        }
    }
}
