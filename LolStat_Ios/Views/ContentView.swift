//
//  UnderTabBar.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/5/23.
//

import SwiftUI

struct ContentView: View {
    init(){
        UITabBar.appearance().scrollEdgeAppearance = .init()
        //UITabBar.appearance().backgroundColor = .black
    }
    
    var body: some View {
        TabView{
            Main()
                .tabItem{
                    Image(.search)
                    Text("Search")
                }
            
            Ranking()
                .tabItem {
                    Image(.ranking)
                    Text("Ranking")
                }
            Duo()
                .tabItem{
                    Text("DUO")
                }
        }
        .accentColor(.green)
        .font(.headline)
    }
}
