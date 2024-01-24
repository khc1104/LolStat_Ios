//
//  AccountStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/19/24.
//

import Foundation
import ComposableArchitecture

struct AccountStore : Reducer{
    struct State : Equatable{
        @BindingState var email : String = ""
        @BindingState var password : String = ""
        var LoginResponse : LoginResponse?
        
    }
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case requestLoginTest
        case responseLogin(LoginResponse)
        
        case joinButtonTapped
    }
    var body : some ReducerOf<Self>{
        BindingReducer()
        
        Reduce(self.joinAcountReducer)
    }
    
    @Dependency(\.accountAPIClient) var accountAPI
    func joinAcountReducer(into state : inout State, action: Action) -> Effect<Action>{
        switch action{
            //
            //API Request
            //
            //로그인 요청 - 테스트
            case .requestLoginTest:
            
            return .run{ send in
                if let response = try await accountAPI.requestLoginUserTest(){
                    await send(.responseLogin(response))
                }else{
                    print("loginResponseError")
                }
            }
            
            //
            //API Response
            //
            case let.responseLogin(loginResponse):
            state.LoginResponse = loginResponse
            return .none
            //회원가입 버튼 눌렀을 때
        case .joinButtonTapped:
            return .run{send in
                await send(.requestLoginTest)
            }
        
                case .binding:
            return .none
        }
    }
    
}
