//
//  Main.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/06.
//

import Foundation
import SwiftUI
import ComposableArchitecture


struct Main: View {
    
    var body: some View{
        Search(store: LolStat_IosApp.userStore)
    }
}
