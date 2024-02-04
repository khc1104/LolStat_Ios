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
            if positions.count <= 2{
                ForEach(positions, id: \.self){position in
                    Image(position.image()).resizable()
                        .frame(width: width, height: height)
                }
            }else{
                ForEach(0..<2){ i in
                    Image(positions[i].image()).resizable()
                        .frame(width: width, height: height)
                }
                ZStack{
                    Text("+")
                        .font(.kingSejong(.bold, size: 30))
                }
                .frame(width: width, height: height)
            }
        }
    }
}
