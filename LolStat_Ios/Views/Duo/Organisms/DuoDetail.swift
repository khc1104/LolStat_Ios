//
//  DuoDetail.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct DuoDetail: View {
    let store : StoreOf<DuoDetailStore>
    var body: some View {
        WithViewStore(store, observe: {$0}){ viewStore in
            ScrollView{
                if let duoDetail = viewStore.duoDetail{
                    DuoDetailInfo(duo: duoDetail)
                    ForEach(duoDetail.tickets){ ticket in
                        VStack{
                            DuoTicket(ticket : ticket)
                            if viewStore.duoId == viewStore.myDuoId && !duoDetail.matched{
                                Button("신청수락"){
                                    viewStore.send(.acceptButtonTapped(Int(ticket.id)))
                                }
                            }
                        }
                        
                    }
                    if viewStore.duoId != viewStore.myDuoId && !duoDetail.matched{
                        DuoTicketCreate(store : store)
                    }
                }
            }
            .sheet(store: self.store.scope(
                state: \.$accountStore,
                action: DuoDetailStore.Action.accountStore)
            ){accountStore in
                DuoLoadingRefresh(store: accountStore)
            }
            .alert(viewStore.alertMessage ,isPresented: viewStore.$isAlert){
                Button("확인", role: .cancel){
                    viewStore.send(.alertConfirmButtonTapped)
                }
            }
            .onAppear{
                viewStore.send(.duoDetailOnAppear)
            }
            .toolbar{
                ToolbarItem{
                    Button("Cancle"){
                        viewStore.send(.cancleButtonTapped)
                    }
                }
            }
            
        }
    }
}
