//
//
//  LolStat_IosApp.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
//

import SwiftUI
import ComposableArchitecture

@main
struct LolStat_IosApp: App {
    static let store = Store(initialState: UserStore.State()) {
        UserStore()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
