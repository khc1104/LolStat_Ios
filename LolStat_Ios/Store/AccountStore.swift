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
        case requestAuthTest
        
        case loginButtonTapped
        case joinButtonTapped
        case testButtonTapped
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
            //토큰 유효성 - 테스트
        case .requestAuthTest:
            return .run{send in
                    if try await
                        accountAPI.requestAuthTest(){
                        print("true")
                    }else{
                        print("authTestError")
                    }
            }
            
            //
            //API Response
            //
            case let.responseLogin(loginResponse):
        
            KeyChain.create(key: "RefreshToken", token: loginResponse.refreshToken)
            KeyChain.create(key: "AccessToken", token: loginResponse.accessToken)
            return .none
            
            //
            //로그인 페이지 액션
            //
            //로그인 버튼 눌렀을 때
        case .loginButtonTapped:
            return .run{send in
                await send(.requestLoginTest)
            }
        
            //회원가입 버튼 눌렀을 때
        case .joinButtonTapped:
            
            let accessToken = KeyChain.read(key: "AccessToken")
            let refreshToken = KeyChain.read(key: "RefreshToken")
            print("refresh -\(refreshToken as Any)")
            print("access -\(accessToken as Any)")
            return .none
        case .testButtonTapped:
            
            return .run{ send in
                await send(.requestAuthTest)
            }
                case .binding:
            return .none
        }
    }
    
}
