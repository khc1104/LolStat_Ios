//
//  DuoTicketCreate.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/11/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct DuoTicketCreate : View {
    let store : StoreOf<DuoDetailStore>
    @State var summonerName = ""
    @State var tagLine = ""
    @State var memo = ""
    @State var lines : [Line : Bool] = [Line.TOP : false, Line.JG : false, Line.MID : false, Line.AD : false, Line.SUP : false]
    var body: some View {
        WithViewStore(store, observe: {$0}){viewStore in
            VStack{
                HStack{
                    VStack{
                        Text("소환사 이름")
                        DuoSearchSummonerNameInput(gameName: viewStore.$gameName)
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack{
                        Text("태그")
                        DuoSearchTagLineInput(tagLine: viewStore.$tagLine)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                HStack{
                    Text("주 포지션")
                    DuoSearchMainPositionInput(lines: viewStore.$position)
                }
                HStack{
                    Text("메모")
                    DuoSearchMemoInput(memo: viewStore.$memo)
                        .textFieldStyle(.roundedBorder)
                }
                Button("신청"){
                    viewStore.send(.createButtonTapped)
                }
            }
            .frame(width: Const.Screen.WIDTH)
            .background(Color.gray)
            .foregroundColor(.white)
        }
    }
}
/*
struct DuoTicketCreatePreview : PreviewProvider{
    static var previews: some View{
        DuoTicketCreate()
    }
}
*/
