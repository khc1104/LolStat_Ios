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
    
    var store : StoreOf<AccountStore>
    var body: some View {
        WithViewStore(self.store, observe: {$0}){viewStore in
            Form{
                VStack(alignment: .center){
                    LoginEmailInput(email : viewStore.$email)
                        .focused($focusedField, equals: .email)
                        .onSubmit {
                            focusedField = .password
                        }
                    LoginPasswordInput(password : viewStore.$password)
                        .focused($focusedField, equals: .password)
                        .onSubmit {
                            viewStore.send(.loginButtonTapped)
                        }
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
            }
            .toolbar{
                ToolbarItem{
                    Button("Cancle"){
                        viewStore.send(.cancleButtonTapped)
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
