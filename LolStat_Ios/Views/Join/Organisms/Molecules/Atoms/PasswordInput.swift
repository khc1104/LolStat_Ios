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
    let store : StoreOf<JoinStore>
    @Binding var isAnimation: Bool
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            VStack{
                ZStack(alignment: .leading){
                    SecureField("", text: viewStore.$password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.oneTimeCode)
                        .textInputAutocapitalization(.never)
                    Text("비밀번호")
                        .font(.kingSejong(.regular, size: isAnimation ? 16 : 20))
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
            .frame(minHeight:100)
        }
    }
}
