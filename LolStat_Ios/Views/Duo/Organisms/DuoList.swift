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
                HStack{
                    Button{
                        viewStore.send(.logOutButtonTapped)
                    }label: {
                        Text("Logout")
                            .padding()
                            .frame(width: Const.Screen.WIDTH * 0.48)
                            .background(.loseRed)
                            .cornerRadius(8)
                        
                    }
                    Button{
                        viewStore.send(.duoSearchButtonTapped)
                    }label: {
                        Text("듀오 찾기")
                            .padding()
                            .frame(width: Const.Screen.WIDTH * 0.48)
                            .background(.gray)
                            .cornerRadius(8)
                        
                    }
                }
                DuoMatchPicker(selectedMatch: viewStore.$selectedMatch)
                DuoQueueTypePicker(selectedQueue: viewStore.$selectedQueue)
                Button{
                    viewStore.send(.duoListSearchButtonTapped)
                }label: {
                    Text("검색")
                        .padding()
                        .frame(width: Const.Screen.WIDTH)
                        .background(.verifyBlue)
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
