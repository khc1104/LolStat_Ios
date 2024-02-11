//
//  DuoSearchTagLineInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoSearchTagLineInput: View {
    @Binding var tagLine : String
    var body: some View {
        TextField("태그", text: $tagLine)
            .textInputAutocapitalization(.never)
    }
}
