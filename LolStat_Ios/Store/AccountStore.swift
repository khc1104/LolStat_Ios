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
        @BindingState var verifyCode : String = ""
        var isLogin : Bool = false
        var isVerified: Bool = true

        @PresentationState var joinStore: JoinStore.State?
        
    }
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case requestLogin
        case requestLoginTest
        case responseLogin(LoginResponse)
        case requestAuthTest
        case responseAuthTest(Int)
        case requestRefreshToken
        case responseRefreshToken(String)
        case requestUserVerify
        case responseUserVerify(Int)
        
        case duoOnAppear
        case LogOutButtonTapped
        
        case loginButtonTapped
        case joinButtonTapped
        case UserVerifyButtonTapped
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
            //로그인 요청
        case .requestLogin:
            let pwd = "\(state.password)"
            let loginUser = LoginRequest(email: state.email, password: pwd)
            return .run{ send in
                if let response = try await accountAPI.requestLogin(user:loginUser){
                    await send(.responseLogin(response))
                }else{
                    print("loginResponseError")
                }
            }
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
        case .requestUserVerify:
            let code = UserVerifyRequest(verificationCode: state.verifyCode)
            return .run{ send in
                if let response = try await accountAPI.requestUserVerify(code: code){
                    await send(.responseUserVerify(response))
                }else{
                    print("userVerifyError")
                }
            }
            //
            //API Response
            //
            //로그인 반환
        case let .responseLogin(loginResponse):
            
            KeyChain.create(key: "RefreshToken", token: loginResponse.refreshToken)
            KeyChain.create(key: "AccessToken", token: loginResponse.accessToken)
            state.isLogin = true
            return .none
            //토큰 인증 반환
        case let .responseAuthTest(authResponse):
            //state.testResponse = authResponse
            if(authResponse == 1005){
                return .run{send in
                    await send(.requestRefreshToken)
                }
            }else if(authResponse == 1003){
                state.isVerified = false
                return .none
            }else{
                print("승인")
                return .none
            }
            //토큰 리프레쉬 반환
        case let .responseRefreshToken(tokenResponse):
            if tokenResponse == "1005"{
                KeyChain.delete(key: "RefreshToken")
                KeyChain.delete(key: "AccessToken")
                state.isLogin = false
                print("Logout!!")
            }else{
                KeyChain.create(key: "AccessToken", token: tokenResponse)
                state.isLogin = true
            }
            return .none
            //유저 인증 반환
        case let .responseUserVerify(response):
            if response == 200{
                state.isVerified = true
            }
            else{
                print(response)
            }
            
            return .none
            //
            //듀오페이지 액션
            //
            //듀오페이지 onAppear
        case .duoOnAppear:
            return .run{send in
                await send(.requestRefreshToken)
            }
            //로그아웃 버튼 눌렀을 때
        case .LogOutButtonTapped:
            KeyChain.delete(key: "AccessToken")
            KeyChain.delete(key: "RefreshToken")
            state.isLogin = false
            return .none
            //
            //로그인 페이지 액션
            //
            //로그인 버튼 눌렀을 때
        case .loginButtonTapped:
            return .run{send in
                await send(.requestLogin)
            }
            
            //회원가입 버튼 눌렀을 때
        case .joinButtonTapped:
            state.joinStore = JoinStore.State()
            return .none
            //
            //이메일 인증 페이지
            //
            //인증버튼 눌렀을 때
        case .UserVerifyButtonTapped:
            return .run{ send in
                await send(.requestUserVerify)
            }
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
