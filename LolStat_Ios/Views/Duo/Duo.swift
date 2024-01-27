//
//  Duo.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/27/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct Duo: View {
    let store : StoreOf<AccountStore> = LolStat_IosApp.accountStore
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            VStack{
                if viewStore.isLogin{
                    Text("Duo")
                    Button("로그아웃"){
                        viewStore.send(.LogOutButtonTapped)
                    }
                }else{
                    Login()
                }
            }.onAppear{viewStore.send(.duoOnAppear)}
        }
    }
}
