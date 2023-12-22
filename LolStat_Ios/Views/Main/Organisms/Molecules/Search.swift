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
        NavigationStackStore(self.store.scope(state: \.path, action: MainStore.Action.path)){
            WithViewStore(self.store, observe: {$0}){ viewStore in
                VStack{
                    Spacer()
                    Form{
                        
                        HStack{
                            TextField("소환사 이름", text: viewStore.$summonerName)
                            ZStack{
                                NavigationLink(state: UserStore.State(summonerName: viewStore.summonerName)){
                                     EmptyView()
                                }
                                .opacity(1)
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
                            }
                        }
                    }
                }
            }
        } destination: { store in
            User(store: store)
        }
    }
}
/*
struct Preview_Search: PreviewProvider{
    static var previews: some View{
        Search(
            store: .init(
                initialState: .init(),
                reducer:{
                    MainStore()
                        ._printChanges()
                })
        )
    }
}
*/
