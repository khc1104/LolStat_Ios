//
//  DuoSearchWishTierInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoSearchWishTierInput: View {
    @State var lines : [Line : Bool] = [Line.TOP : false, Line.JG : false, Line.MID : false, Line.AD : false, Line.SUP : false]
    var body: some View {
        HStack(spacing: 0){
            DuoSelectPosition(position: Line.TOP)
                .onTapGesture {
                    lines[Line.TOP]?.toggle()
                }
            DuoSelectPosition(position: Line.JG)
                .onTapGesture {
                    lines[Line.JG]?.toggle()
                }
            DuoSelectPosition(position: Line.MID)
                .onTapGesture {
                    lines[Line.MID]?.toggle()
                }
            DuoSelectPosition(position: Line.AD)
                .onTapGesture {
                    lines[Line.AD]?.toggle()
                }
            DuoSelectPosition(position: Line.SUP)
                .onTapGesture {
                    lines[Line.SUP]?.toggle()
                }
        }
    }
}
/*
struct whishTierPreview : PreviewProvider{
    static var previews: some View{
        DuoSearchWishTierInput()
    }
}
*/
