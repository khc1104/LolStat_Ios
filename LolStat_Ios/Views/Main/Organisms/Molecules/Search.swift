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
    
    var body: some View{
        NavigationStackStore(self.store.scope(state: \.path, action: UserStore.Action.path)){
            WithViewStore(self.store, observe: {$0}){ viewStore in
                VStack{
                    Spacer()
                    Form{
                        
                        HStack{
                            TextField("소환사 명", text: viewStore.$summonerName)
                                .padding()
                            ZStack{
                                NavigationLink(state: UserStore.State()){
                                     EmptyView()
                                }
                                .opacity(0)
                                HStack{
                                    Button("search"){
                                        viewStore.send(.searchUserInfo)
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

struct Preview_Search: PreviewProvider{
    static var previews: some View{
        Search(
            store: .init(
                initialState: .init(),
                reducer:{
                    UserStore()
                        ._printChanges()
                })
        )
    }
}
