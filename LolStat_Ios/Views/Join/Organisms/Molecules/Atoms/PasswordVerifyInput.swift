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
    let store : StoreOf<JoinStore>
    @Binding var isAnimation: Bool
    var body: some View {
        WithViewStore(self.store, observe:{$0}){viewStore in
            VStack{
                ZStack(alignment: .leading){
                    SecureField("", text: viewStore.$passwordVerify)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.oneTimeCode)
                        
                    Text("비밀번호 확인")
                        .font(.kingSejong(.regular, size: isAnimation ? 16 : 20))
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
            .frame(minHeight:100)
        }
    }
}
