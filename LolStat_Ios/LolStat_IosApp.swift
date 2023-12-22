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
    static let mainStore = Store(initialState: MainStore.State()) {
        MainStore()
            ._printChanges()
    }
    
    static let userStore = Store(initialState: UserStore.State()){
        UserStore()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
