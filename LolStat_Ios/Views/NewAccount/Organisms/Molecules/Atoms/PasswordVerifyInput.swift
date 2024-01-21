//
//  PasswordVerifyInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/20/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PasswordVerifyInput:View {
    let store : StoreOf<AccountStore>
    @Binding var isAnimation: Bool
    var body: some View {
        WithViewStore(self.store, observe:{$0}){viewStore in
            VStack{
                ZStack{
                    SecureField("", text: viewStore.$passwordVerify)
                    Text("비밀번호 확인")
                        .foregroundStyle(viewStore.passwordVerify != "" &&
                                         viewStore.isPasswordVerifyVerified ? .verifyBlue :
                                            viewStore.passwordVerify != "" &&
                                         !viewStore.isPasswordVerifyVerified ? .red :.secondary)
                        .offset(y:isAnimation ? -30 : 0)
                }
                Text(viewStore.passwordVerifyMessage)
                    .foregroundStyle(.red)
                    .font(.kingSejong(.regular, size: 20))
            }
        }
    }
}
