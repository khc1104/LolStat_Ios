//
//  VerifyGroup.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/19/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct VerifyGroup: View {
    enum focusField : Hashable{
        case email
        case password
        case passwordVerify
    }
    @FocusState private var focusedField: focusField?
    @State private var isEmailAnimation : Bool = false
    @State private var isPasswordAnimation : Bool = false
    @State private var isPasswordVerifyAnimation : Bool = false
    
    
    let store : StoreOf<AccountStore> = LolStat_IosApp.accountStore
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            VStack(alignment: .center){
                Text("회원 가입")
                
                EmailInput(store:store, isAnimation: $isEmailAnimation)
                    .focused($focusedField, equals: .email)
                    .onChange(of: viewStore.$email){ _ in
                        viewStore.send(.verifyEmail)
                    }
                    .onTapGesture {
                        focusedField = .email
                    }
                Spacer()
                PasswordInput(store: store, isAnimation: $isPasswordAnimation)
                    .focused($focusedField, equals: .password)
                    .onChange(of: viewStore.$password){ _ in
                        viewStore.send(.verifyPassword)
                    }
                    .onTapGesture {
                        focusedField = .password
                    }
                Spacer()
                PasswordVerifyInput(store: store, isAnimation: $isPasswordVerifyAnimation)
                    .focused($focusedField, equals: .passwordVerify)
                    .onChange(of: viewStore.$passwordVerify){ _ in
                        viewStore.send(.verifyPasswordVerify)
                    }
                    .onTapGesture {
                        focusedField = .passwordVerify
                    }
                    Spacer()
                JoinButton(disable: viewStore.isEmailVerified && viewStore.isPasswordVerified && viewStore.isPasswordVerifyVerified ? false : true)
                .onTapGesture {
                    viewStore.send(.joinButtonTapped)
                }
                //.disabled(viewStore.isEmailVerified && viewStore.isPasswordVerified && viewStore.isPasswordVerifyVerified ? false : true)
            }
            .textFieldStyle(.roundedBorder)
            .frame(maxHeight: Const.Screen.HEIGHT)
            .background(.defalutBackground)
            .font(.kingSejong(.regular, size: 36))
            .onChange(of: focusedField){ _ in
                switch focusedField{
                case .email:
                    withAnimation(.default){
                        isEmailAnimation = true
                        if viewStore.password == ""{
                            isPasswordAnimation = false
                        }
                        if viewStore.passwordVerify == ""{
                            isPasswordVerifyAnimation = false
                        }
                    }
                case .password:
                    withAnimation(.default){
                        if viewStore.email == ""{
                            isEmailAnimation = false
                        }
                        isPasswordAnimation = true
                        if viewStore.passwordVerify == ""{
                            isPasswordVerifyAnimation = false
                        }
                    }
                case .passwordVerify:
                    withAnimation(.default){
                        if viewStore.email == ""{
                            isEmailAnimation = false
                        }
                        if viewStore.password == ""{
                            isPasswordAnimation = false
                        }
                        isPasswordVerifyAnimation = true
                    }
                case .none:
                    withAnimation(.default){
                        if viewStore.email == ""{
                            isEmailAnimation = false
                        }
                        if viewStore.password == ""{
                            isPasswordAnimation = false
                        }
                        if viewStore.passwordVerify == ""{
                            isPasswordVerifyAnimation = false
                        }
                    }
                }
            }
        }
    }
}
