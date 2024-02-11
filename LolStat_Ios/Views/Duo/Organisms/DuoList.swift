//
//  DuoList.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/1/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct DuoList: View {
    let store : StoreOf<DuoStore>
    var body: some View {
        WithViewStore(store, observe: {$0}){viewStore in
            ScrollView{
                Text("Duo")
                Button{
                    viewStore.send(.logOutButtonTapped)
                }label: {
                    Text("Logout")
                        .padding()
                        .frame(width: Const.Screen.WIDTH)
                        .background(.loseRed)
                        .cornerRadius(8)
                    
                }
                Button{
                    viewStore.send(.duoSearchButtonTapped)
                }label: {
                    Text("듀오 찾기")
                        .padding()
                        .frame(width: Const.Screen.WIDTH)
                        .background(.loseRed)
                        .cornerRadius(8)
                    
                }
                .sheet(store: self.store.scope(
                    state: \.$duoSearchStore,
                    action: DuoStore.Action.duoSearchStore)
                ){ duoSearch in
                    NavigationStack{
                        DuoSearch(store: duoSearch)
                    }
                    
                }
                
                if let duoList = viewStore.duoList{
                    ForEach(duoList){ duo in
                        DuoColumn(duo: duo)
                            .onTapGesture {
                                viewStore.send(.duoInfoTapped(Int(duo.id)))
                            }
                            .sheet(store:self.store.scope(
                                state: \.$duoDetailStore,
                                action: DuoStore.Action.duoDetailStore)
                            ){ duoDetail in
                                NavigationStack{
                                    DuoDetail(store: duoDetail)
                                }
                            }
                           
                    }
                }
            }
           
        }
    }
}
