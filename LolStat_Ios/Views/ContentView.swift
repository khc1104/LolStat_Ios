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
                    Image(systemName: "1.square.fill")
                    Text("Home")
                }
                            Ranking()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Ranking")
                }
        }
        .accentColor(.green)
        .font(.headline)
    }
}
