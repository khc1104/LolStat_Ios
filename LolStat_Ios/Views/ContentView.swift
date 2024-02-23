//
//  UnderTabBar.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/5/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    init(){
        UITabBar.appearance().scrollEdgeAppearance = .init()
        //UITabBar.appearance().backgroundColor = .black
    }
    var store : StoreOf<DuoStore> = LolStat_IosApp.duoStore
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            TabView(selection: viewStore.$selectedView){
                Main()
                    .tabItem{
                        Image(.search)
                        Text("Search")
                    }
                    .tag(TabViewState.MAIN)
                
                Ranking()
                    .tabItem {
                        Image(.ranking)
                        Text("Ranking")
                    }
                    .tag(TabViewState.RANKING)
                Duo()
                    .tabItem{
                        Text("DUO")
                    }
                    .tag(TabViewState.DUO)
                if viewStore.isLogin{
                    MyPage(store: store)
                        .tabItem{
                            Text("My")
                        }
                        .tag(TabViewState.MYPAGE)
                }
                
                
            }
            .accentColor(.green)
            .font(.headline)
        }
    }
}
