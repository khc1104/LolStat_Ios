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
    
    let store: StoreOf<UserStore>
    
    var body: some View{
        NavigationStack {
            WithViewStore(self.store, observe: {$0}) { viewStore in
                Search()
                
            }
        }
    }
}
