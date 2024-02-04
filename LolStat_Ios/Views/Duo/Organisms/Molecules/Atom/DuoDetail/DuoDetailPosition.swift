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
    var body: some View {
        HStack(spacing: 0){
            DuoSelectPosition(position: Line.TOP, isSelect: lines.contains(Line.TOP))
            DuoSelectPosition(position: Line.JG, isSelect: lines.contains(Line.JG))
            DuoSelectPosition(position: Line.MID, isSelect:lines.contains(Line.MID))
            DuoSelectPosition(position: Line.AD, isSelect:lines.contains(Line.AD))
            DuoSelectPosition(position: Line.SUP, isSelect:lines.contains(Line.SUP))
        }
    }
}
