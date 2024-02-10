//
//  DuoSearchMemoInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoSearchMemoInput: View {
    @State var memo : String = ""
    var body: some View {
        TextField("", text: $memo)
    }
}
