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
    let store : StoreOf<UserStore> = LolStat_IosApp.userStore
    var body: some View{
        WithViewStore(self.store, observe:{$0}){ viewStore in
            NavigationStack{
                VStack{
                    Search(store: store)
                        .frame(height: 24)
                    SavedSummoner(store: store)
                }
                .frame(width: Const.Screen.WIDTH)
                .background(.defaultBackground)
                .navigationDestination(isPresented: viewStore.$isSearchTapped){
                    User(store: store)
                        .navigationBarBackButtonHidden(true)
                        .toolbar{
                            ToolbarItem(placement: .navigationBarLeading){
                                Button("뒤로"){
                                    viewStore.send(.backButtonTapped)
                                }
                            }
                        }
                }
            }
        }
    }
}
