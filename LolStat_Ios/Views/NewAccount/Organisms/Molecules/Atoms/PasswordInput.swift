//
//  PasswordInput.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/20/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PasswordInput:View {
    let store : StoreOf<AccountStore>
    @Binding var isAnimation: Bool
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            VStack{
                ZStack{
                    SecureField("", text: viewStore.$password)
                        .onChange(of: viewStore.$password){_ in
                            viewStore.send(.verifyPassword)
                        }
                    Text("비밀번호")
                        .foregroundStyle(viewStore.password != "" &&
                                         viewStore.isPasswordVerified ? .verifyBlue :
                                            viewStore.password != "" &&
                                         !viewStore.isPasswordVerified ? .red :.secondary)
                        .offset(y:isAnimation ? -30 : 0)
                }
                Text(viewStore.passwordMessage)
                    .foregroundStyle(.red)
                    .font(.kingSejong(.regular, size: 20))
            }
        }
    }
}
