//
//  Duo.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/27/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct Duo: View {
    let store : StoreOf<DuoStore> = LolStat_IosApp.duoStore
    @State var test = false
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            DuoList(store: store)
                .onAppear{
                    viewStore.send(.duoOnAppear)
                }
                .fullScreenCover(store: self.store.scope(
                    state: \.$accountStore,
                    action: DuoStore.Action.accountStore)
                ){accountStore in
                    if !viewStore.isAccessToken{
                        DuoLoadingRefresh(store: accountStore)
                    }
                    if !viewStore.isAccessToken && !viewStore.isLogin{
                        Login(store:accountStore)
                    }
                    
                }
            
                .alert(viewStore.alertMessage ,isPresented: viewStore.$isAlert){
                    Button("확인", role: .cancel){
                        viewStore.send(.alertConfirmButtonTapped)
                    }
                }
        }
    }
}
