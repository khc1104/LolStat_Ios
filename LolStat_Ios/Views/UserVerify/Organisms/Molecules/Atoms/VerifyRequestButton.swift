//
//  VerifyRequest.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/24/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct VerifyRequestButton: View {
    var store : StoreOf<AccountStore>
    var body: some View {
        WithViewStore(store, observe: {$0}){viewStore in
            Button{
                viewStore.send(.userVerifyAgainButtonTapped)
            }label: {
                Text("재요청")
                    .padding(8)
                    .cornerRadius(8)
                    .font(.kingSejong(.regular, size: 12))
                    .background(.secondary)
                    .foregroundColor(.white)
                
            }
        }
    }
}
