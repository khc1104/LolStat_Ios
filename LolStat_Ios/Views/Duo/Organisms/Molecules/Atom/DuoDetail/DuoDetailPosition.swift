//
//  DuoDetailPostion.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoDetailPosition: View {
    var body: some View {
        HStack{
            DuoSelectPosition(position: Line.TOP, isSelect:true)
            DuoSelectPosition(position: Line.JG, isSelect:true)
            DuoSelectPosition(position: Line.MID, isSelect:true)
            DuoSelectPosition(position: Line.AD, isSelect:true)
            DuoSelectPosition(position: Line.SUP, isSelect:true)
        }
    }
}

struct positionPreview : PreviewProvider{
    static var previews: some View{
        DuoDetailPosition()
    }
}
