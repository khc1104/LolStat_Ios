//
//  DuoSearchMainPositionInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoSearchMainPositionInput: View{
    @State var lines : [Line : Bool] = [Line.TOP : false, Line.JG : false, Line.MID : false, Line.AD : false, Line.SUP : false]
    var body: some View {
        HStack(spacing: 0){
            DuoSelectPosition(position: Line.TOP, isSelect: lines[Line.TOP]!)
                .onTapGesture {
                    lines[Line.TOP]?.toggle()
                }
            DuoSelectPosition(position: Line.JG, isSelect: lines[Line.JG]!)
                .onTapGesture {
                    lines[Line.JG]?.toggle()
                }
            DuoSelectPosition(position: Line.MID, isSelect: lines[Line.MID]!)
                .onTapGesture {
                    lines[Line.MID]?.toggle()
                }
            DuoSelectPosition(position: Line.AD, isSelect: lines[Line.AD]!)
                .onTapGesture {
                    lines[Line.AD]?.toggle()
                }
            DuoSelectPosition(position: Line.SUP, isSelect: lines[Line.SUP]!)
                .onTapGesture {
                    lines[Line.SUP]?.toggle()
                }
        }
    }
}
