//
//  UserVerifyGroup.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/28/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct UserVerifyGroup: View {
    let store : StoreOf<AccountStore>
    var body: some View {
        WithViewStore(store.self, observe: {$0}){viewStore in
            Form{
                HStack{
                    VerifyCodeInput(verifycode: viewStore.$verifyCode)
                    VerifyTimer()
                }
                VerifyButton()
                    .onTapGesture {
                        viewStore.send(.UserVerifyButtonTapped)
                    }
            }
        }
    }
}
/*
struct verifyPreview : PreviewProvider{
    static var previews: some View{
        UserVerifyGroup(store: Store)
    }
}
*/
