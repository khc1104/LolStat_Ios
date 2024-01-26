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

        @PresentationState var joinStore: JoinStore.State?
        
    }
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case requestLoginTest
        case responseLogin(LoginResponse)
        case requestAuthTest
        case responseAuthTest(Int)
        case requestRefreshToken
        case responseRefreshToken(String)
        
        case loginButtonTapped
        case joinButtonTapped
        case testButtonTapped
        
        case joinStore(PresentationAction<JoinStore.Action>)
    }
    var body : some ReducerOf<Self>{
        BindingReducer()
        
        Reduce(self.joinAcountReducer)
            .ifLet(\.$joinStore, action:/Action.joinStore){
                JoinStore()
            }
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
                if let response = try await
                    accountAPI.requestAuthTest(){
                    await send(.responseAuthTest(response))
                    print("true")
                }else{
                    print("authTestError")
                }
            }
            //토큰 재발급 요청
        case .requestRefreshToken:
            return .run{ send in
                if let accessToken = try await accountAPI.requestRefreshToken(){
                    await send(.responseRefreshToken(accessToken))
                }else{
                    print("refreshTokenError")
                }
            }
            //
            //API Response
            //
            //로그인 반환
        case let .responseLogin(loginResponse):
            
            KeyChain.create(key: "RefreshToken", token: loginResponse.refreshToken)
            KeyChain.create(key: "AccessToken", token: loginResponse.accessToken)
            return .none
            //토큰 인증 반환
        case let .responseAuthTest(authResponse):
            //state.testResponse = authResponse
            if(authResponse == 1005){
                return .run{send in
                    await send(.requestRefreshToken)
                }
            }else{
                print("승인")
                return .none
            }
        case let .responseRefreshToken(tokenResponse):
            if tokenResponse == "1005"{
                KeyChain.delete(key: "RefreshToken")
                KeyChain.delete(key: "AccessToken")
                print("Logout!!")
            }else{
                KeyChain.create(key: "AccessToken", token: tokenResponse)
            }
            
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
            state.joinStore = JoinStore.State()
            return .none
        case .testButtonTapped:
            
            return .run{ send in
                //await send(.requestRefreshToken)
                await send(.requestAuthTest)
            }
        case .binding:
            return .none
            
        case .joinStore(.presented(.cancleButtonTapped)):
            state.joinStore = nil
            return .none
        case .joinStore:
                return .none
        }
            
    }
    
}
