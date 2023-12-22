//
//  Spell.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/7/23.
//

import Foundation
import SwiftUI

struct SpellGroup : View{
    let spells: [Spell]
    
    var body : some View{
        VStack(spacing: 0){
            ForEach(0..<2){ i in
                SpellIcon(spell: spells[i])
            }
        }
    }
}
