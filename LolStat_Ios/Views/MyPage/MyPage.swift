//
//  MyPage.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/22/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct MyPage : View {
    var store : StoreOf<DuoStore>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            Button{
                viewStore.send(.logOutButtonTapped)
            }label: {
                Text("로그아웃")
                    .frame(width: Const.Screen.WIDTH)
                    .background(.red)
                    .foregroundColor(.white)
                    .font(.kingSejong(.bold, size: 26))
                    .cornerRadius(8)
            }
        }
    }
}
