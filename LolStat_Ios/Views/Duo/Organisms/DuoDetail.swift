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
            VStack{
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
