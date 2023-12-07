//
//  Search.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/08.
//

import ComposableArchitecture
import SwiftUI



struct Search: View{
    
    
    var body: some View{
            HStack{
                SearchInput(store: LolStat_IosApp.store)
                NavigationLink(destination: User()){
                    SearchButton(store: LolStat_IosApp.store)
                }
                
            }
        }
}
