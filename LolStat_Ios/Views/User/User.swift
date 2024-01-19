//
//  User.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/16.
//

import ComposableArchitecture
import SwiftUI


struct User : View{
    let store : StoreOf<UserStore>
    
    var body : some View{
        WithViewStore(self.store, observe: {$0}){ viewStore in
            VStack{
                if viewStore.isLoading{
                    ProgressView()
                    /*.onAppear{
                     viewStore.send(.userPageOnAppear)
                     }
                     */
                }
                else{
                    if let summonerInfo = viewStore.summonerInfo, let matches = viewStore.searchedSummonerMatches
                    {
                        SummonerInfoPage(store: store, profile: summonerInfo.profile,
                                         matches: matches)
                        .font(.kingSejong(.bold, size: 17))
                        .onAppear{
                            viewStore.send(.summonerInfoOnAppear)
                        }
                    }else if viewStore.isTimeOut{
                        Text("TimeOut")
                    }
                    else if viewStore.summonerInfo == nil{
                        Text("존재하지 않는 소환사 입니다.")
                            
                    }
                }
            }
            .onAppear{
                viewStore.send(.userPageOnAppear)
            }
            .task {
                
                do{
                    try await Task.sleep(for: .seconds(60))
                    viewStore.send(.userPageOnAppearTimeOut)
                }
                catch{
                    print("UserPage Error")
                }
            }
        }
    }
}
/*
struct Preview_User: PreviewProvider{
    static var previews: some View{
        User(store: .init(
            initialState: .init(),
            reducer:{
                UserStore()
                    ._printChanges()
            }
            )
        )
    }
}
*/
