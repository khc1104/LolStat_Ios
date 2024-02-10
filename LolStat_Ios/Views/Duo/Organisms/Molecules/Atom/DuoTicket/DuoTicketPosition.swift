//
//  DuoTicketPosition.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoTicketPosition :View {
    var positions : [Line]
    var body: some View {
        HStack{
            ForEach(positions, id: \.self){position in
                Image(position.image()).resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}
