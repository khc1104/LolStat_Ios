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
    let store : StoreOf<JoinStore>
    @Binding var isAnimation: Bool
    var body: some View {
        WithViewStore(self.store, observe:{$0}){viewStore in
            VStack{
                ZStack(alignment: .topLeading){
                    TextField("", text: viewStore.$email)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                    Text("이메일")
                        .font(.kingSejong(.regular, size: isAnimation ? 16 : 20))
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
            .frame(minHeight:100)
        }
    }
}
