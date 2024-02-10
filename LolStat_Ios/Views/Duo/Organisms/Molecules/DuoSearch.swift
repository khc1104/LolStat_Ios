//
//  DuoSearch.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/10/24.
//

import Foundation
import SwiftUI

struct DuoSearch: View {
    var body: some View {
        Form{
            Text("소환사 이름")
            DuoSearchSummonerNameInput()
            Text("태그")
            DuoSearchTagLineInput()
            Text("주 포지션")
            DuoSearchMainPositionInput()
            Text("찾는 포지션")
            DuoSearchWishPositionInput()
            Text("큐 타입")
            DuoSearchQueueIdInput()
            Text("메모")
            DuoSearchMemoInput()
            Button("글쓰기"){
                
            }
        }
    }
}


struct DuoSearchPreview: PreviewProvider{
    static var previews: some View{
        DuoSearch()
    }
}
