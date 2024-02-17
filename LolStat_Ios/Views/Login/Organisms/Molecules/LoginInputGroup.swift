//
//  LoginInputGroup.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/22/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture


struct LoginInputGroup: View {
    enum focusField: Hashable{
        case email
        case password
    }
    @FocusState private var focusedField: focusField?
    @State private var isEmailAnimation : Bool = false
    @State private var isPasswordAnimation : Bool = false
    
    var store : StoreOf<AccountStore>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            Form{
                VStack(alignment: .center){
                    LoginEmailInput(email : viewStore.$email, isAnimation: $isEmailAnimation)
                        .focused($focusedField, equals: .email)
                    LoginPasswordInput(password : viewStore.$password, isAnimation: $isPasswordAnimation)
                        .focused($focusedField, equals: .password)
                    LoginButton()
                        .onTapGesture {
                            viewStore.send(.loginButtonTapped)
                        }
                        .alert("로그인 실패. \n로그인 정보를 확인해주세요.", isPresented: viewStore.$isAlert){
                            Button("확인", role: .cancel){
                                viewStore.send(.alertConfirmButtonTapped)
                            }
                        }
                    GoJoinButton()
                        .onTapGesture {
                            viewStore.send(.joinButtonTapped)
                        }
                }
                .onChange(of: focusedField){ _ in
                    switch focusedField {
                    case .email:
                        withAnimation(.default){
                            isEmailAnimation = true
                            if viewStore.password == ""{
                                isPasswordAnimation = false
                            }
                            
                        }
                    case .password:
                        withAnimation(.default){
                            isPasswordAnimation = true
                            if viewStore.email == ""{
                                isEmailAnimation = false
                            }
                        }
                    case .none:
                        withAnimation(.default){
                            if viewStore.email == ""{
                                isEmailAnimation = false
                            }
                            if viewStore.password == ""{
                                isPasswordAnimation = false
                            }
                        }
                    }
                }
            }
        }
        .sheet(store: self.store.scope(
            state: \.$joinStore,
            action: AccountStore.Action.joinStore)
        ){joinStore in
            NavigationStack{
                Join(store:joinStore)
            }
        }
        
    }
}

/*
struct preview_Login:PreviewProvider{
    static var previews: some View{
        LoginInputGroup()
    }
}

*/
