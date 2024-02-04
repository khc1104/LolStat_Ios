//
//  DuoDetailRecentlyMatches.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoDetailRecentlyMatches: View {
    var matches : [DuoRecentMatchDto]
    var body: some View {
        HStack{
            ForEach(0 ..< matches.count){i in
                    DuoChampion(match: matches[i])
            }
        }
    }
}
