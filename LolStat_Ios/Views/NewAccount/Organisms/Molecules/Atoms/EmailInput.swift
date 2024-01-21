//
//  VerifyEmail.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/19/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct EmailInput : View {
    let store : StoreOf<AccountStore>
    @Binding var isAnimation: Bool
    var body: some View {
        WithViewStore(self.store, observe:{$0}){viewStore in
            VStack{
                ZStack{
                    TextField("", text: viewStore.$email)
                    Text("이메일")
                        .foregroundStyle(viewStore.email != "" &&
                                         viewStore.isEmailVerified ? .verifyBlue :
                                            viewStore.email != "" &&
                                         !viewStore.isEmailVerified ? .red : .secondary)
                        .offset(y:isAnimation ? -30 : 0)
                    
                }
                Text(viewStore.emailMessage)
                    .foregroundStyle(.red)
                    .font(.kingSejong(.regular, size: 20))
            }
            .frame(minHeight:70)
        }
    }
}
