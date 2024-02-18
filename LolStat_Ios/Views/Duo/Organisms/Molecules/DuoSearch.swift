//
//  DuoSearch.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct DuoSearch: View {
    let store : StoreOf<DuoSearchStore>
    var body: some View {
        WithViewStore(store, observe: {$0}){viewStore in
            Form{
                Text("소환사 이름")
                DuoSearchSummonerNameInput(gameName:viewStore.$gameName)
                Text("태그")
                DuoSearchTagLineInput(tagLine: viewStore.$tagLine)
                Text("주 포지션")
                DuoSearchMainPositionInput(lines: viewStore.$mainPosition)
                Text("찾는 포지션")
                DuoSearchWishPositionInput(lines: viewStore.$wishPosition)
                Text("찾는 티어")
                DuoSearchWishTierInput(tiers: viewStore.$wishTier)
                Text("큐 타입")
                DuoSearchQueueIdInput(selectedQueue: viewStore.$queueId)
                Text("메모")
                DuoSearchMemoInput(memo: viewStore.$memo)
                Button("찾기"){
                    viewStore.send(.searchButtonTapped)
                }
            }
            .sheet(store: self.store.scope(
                state: \.$accountStore,
                action: DuoSearchStore.Action.accountStore)
            ){accountStore in
                DuoLoadingRefresh(store: accountStore)
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
/*
struct DuoSearchPreview: PreviewProvider{
    static var previews: some View{
        DuoSearch()
    }
}
*/
