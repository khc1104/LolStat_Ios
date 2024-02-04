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
        var userInfo: UserInfoDto?
        var timer : String = ""
        var isLogin : Bool = false
        var isVerified: Bool = true
        
        @PresentationState var joinStore: JoinStore.State?
        
    }
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case requestLogin
        case requestLoginTest
        case responseLogin(UserInfoDto?)
        case requestAuthTest
        case responseAuthTest(AuthResponse?)
        case requestRefreshToken
        case responseRefreshToken(AuthResponse?)
        case requestUserVerify
        case responseUserVerify(AuthResponse?)
        case timer
        
        case LogOutButtonTapped
        case LoadingOnAppear
        
        case loginButtonTapped
        case joinButtonTapped
        case userVerifyButtonTapped
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
                    print("계정 또는 비밀번호가 틀렸거나 존재하지 않습니다.")
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
            
            if let response = loginResponse{
                state.userInfo = response
                //state.isVerified = response.verified
                state.isLogin = true
                
            }
            return .none
            //토큰 인증 반환
        case let .responseAuthTest(authResponse):
            if let response = authResponse{
                switch response.errorCode{
                case .TOKEN_EXPIRED:
                    return .run{send in
                        await send(.requestRefreshToken)
                    }
                case .NEED_EMAIL_AUTHENTICATION:
                    state.isVerified = false
                    return .none
                case .NO_ERROR:
                    print("액세스토큰 유효")
                    return .none
                default:
                    print(response.message)
                    return .none
                }
            }else{
                return .none
            }
            //return .none
            //토큰 리프레쉬 반환
        case let .responseRefreshToken(tokenResponse):
            if let response = tokenResponse{
                switch response.errorCode{
                case .NO_ERROR:
                    print("토큰 재발급 완료")
                    return .none
                case .TOKEN_EXPIRED:
                    print("토큰 만료")
                    KeyChain.delete(key: Token.REFRESH_TOKEN.rawValue)
                    KeyChain.delete(key: Token.ACCESS_TOKEN.rawValue)
                    state.isLogin = false
                default:
                    print(response.message)
                    KeyChain.delete(key: Token.REFRESH_TOKEN.rawValue)
                    KeyChain.delete(key: Token.ACCESS_TOKEN.rawValue)
                    state.isLogin = false
                }
            }else{
                print("토큰이 비정상적임")
                KeyChain.delete(key: Token.REFRESH_TOKEN.rawValue)
                KeyChain.delete(key: Token.ACCESS_TOKEN.rawValue)
                state.isLogin = false
                return .none
            }
            return .none
            //유저 인증 반환
        case let .responseUserVerify(verifyResponse):
            if let response = verifyResponse{
                switch response.errorCode{
                case .NO_ERROR:
                    state.isVerified = true
                    return .none
                default:
                    state.isVerified = false
                    return .none
                }
            }else{
                return .none
            }
            //return .none
            //
            //듀오페이지 액션
            //
            //로그아웃 버튼 눌렀을 때
        case .LogOutButtonTapped:
            KeyChain.delete(key: "AccessToken")
            KeyChain.delete(key: "RefreshToken")
            state.email = ""
            state.password = ""
            state.isLogin = false
            return .none
            
        case .LoadingOnAppear:
            return .run{send in
                await send(.requestRefreshToken)
            }
            //
            //로그인 페이지 액션
            //
            //로그인 버튼 눌렀을 때
        case .loginButtonTapped:
            return .run{send in
                await send(.requestLogin)
                //await send(.requestLoginTest)
            }
            
            //회원가입 버튼 눌렀을 때
        case .joinButtonTapped:
            state.joinStore = JoinStore.State()
            return .none
            //
            //이메일 인증 페이지
            //
            //인증버튼 눌렀을 때
        case .userVerifyButtonTapped:
            return .run{ send in
                await send(.requestUserVerify)
            }
            //타이머
        case .timer:
            return .none
            //
            //테스트 및 다른 스토어관련
            //
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
