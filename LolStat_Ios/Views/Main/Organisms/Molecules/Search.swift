//
//  Search.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/08.
//

import ComposableArchitecture
import SwiftUI




struct Search: View{
    let store : StoreOf<UserStore>
    //@State var isSearchTapped : Bool = false
    
    var body: some View{
        WithViewStore(self.store, observe: {$0}){ viewStore in
            NavigationStack{
                VStack(alignment: .leading){
                    HStack(spacing: 1){
                        TextField("소환사이름 #KR1", text: viewStore.$summonerName)
                            .frame(width: viewStore.summonerName == "" ? Const.Screen.WIDTH*0.9 : Const.Screen.WIDTH * 0.7)
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.search)
                            .onSubmit {
                                if viewStore.summonerName != ""{
                                    viewStore.send(.searchButtonTapped)
                                }
                            }
                        if viewStore.summonerName != ""{
                            Button("삭제"){
                                viewStore.send(.clearButtonTapped)
                            }
                            .frame(width: Const.Screen.WIDTH * 0.2)
                        }
                    }.navigationDestination(isPresented: viewStore.$isSearchTapped){
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
                    .padding()
                    Spacer()
                }
            }
        }
    }
}
