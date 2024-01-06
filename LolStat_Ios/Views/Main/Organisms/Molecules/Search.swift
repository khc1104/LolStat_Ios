//
//  Search.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/08.
//

import ComposableArchitecture
import SwiftUI




struct Search: View{
    let store : StoreOf<MainStore>
    
    var body: some View{
        WithViewStore(self.store, observe: {$0}){ viewStore in
            NavigationStackStore(self.store.scope(state: \.path, action: MainStore.Action.path)){
                VStack{
                    Form{
                        HStack{
                                TextField("소환사이름 #KR1", text: viewStore.$summonerName)
                                    .frame(width: viewStore.summonerName == "" ? Const.Screen.WIDTH : Const.Screen.WIDTH * 0.8)
                                    .submitLabel(.search)
                            NavigationLink(state: UserStore.State(summonerName: viewStore.summonerName)){
                                Text("search")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            } destination: { store in
                User(store: store)
            }
        }
    }
}
/*HStack{
 Button("search"){
 viewStore.send(.searchButtonTapped)
 }
 .padding()
 .disabled(viewStore.summonerName == "" ? true : false)
 .background(Color(uiColor: .secondarySystemBackground))
 .clipShape(
 RoundedRectangle(
 cornerRadius: 8
 )
 )
 
 }
 */
