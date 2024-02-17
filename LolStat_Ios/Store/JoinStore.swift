//
//  JoinStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/23/24.
//

import Foundation
import ComposableArchitecture

struct JoinStore : Reducer{
    struct State : Equatable{
        @BindingState var email : String = ""
        @BindingState var password : String = ""
        @BindingState var passwordVerify : String = ""
        var emailMessage : String = ""
        var passwordMessage : String = ""
        var passwordVerifyMessage : String = ""
        var isEmailVerified : Bool = false
        var isPasswordVerified : Bool = false
        var isPasswordVerifyVerified : Bool = false
        
        @BindingState var isAlert : Bool = false
        
    }
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case joinButtonTapped
        case cancleButtonTapped
        case verifyEmail
        case verifyPassword
        case verifyPasswordVerify
        case reqeustCreateUser
        case responseCreateUser(AuthResponse?)
        
        case alertConfirmButtonTapped
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
            //회원가입 요청
        case .reqeustCreateUser:
            let pwd = "\(state.password)"
            let pwdck = "\(state.passwordVerify)"
            
            let createAccount = CreateUserRequest(email: state.email,
                                                  password: pwd,
                                                  passwordCheck: pwdck)
            return .run{ send in
                let response = try await accountAPI.requestCreateUser(user: createAccount)
                await send(.responseCreateUser(response))
            }
            
            //
            //API Response
            //
        case let .responseCreateUser(response):
            if let response = response{
                switch response.errorCode{
                case .NO_ERROR:
                    print("회원가입 성공")
                    return .run{ send in
                        await send(.cancleButtonTapped)
                    }
                case .USER_JOIN_FAIL:
                    state.isAlert = true
                    print("회원가입 실패, 이미 존재하는 계정일 수 있음.")
                    return .none
                default:
                    print("anotherError")
                }
            }
            return .none
            //회원가입 버튼 눌렀을 때
        case .joinButtonTapped:
            if state.isEmailVerified && state.isPasswordVerified && state.isPasswordVerifyVerified{
                return .run{send in
                    await send(.reqeustCreateUser)
                }
            }else{
                print("유효성 검사 통과 x")
            }
            return .none
        case .cancleButtonTapped:
            return .none
        case .verifyEmail:
            let emailRegEx = /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/
            if state.email.wholeMatch(of: emailRegEx) != nil{
                state.emailMessage = ""
                state.isEmailVerified = true
            }else{
                if state.email == ""{
                    state.emailMessage = ""
                    state.isEmailVerified = false
                }else{
                    state.emailMessage = "이메일 형식에 맞게 써주세요"
                    state.isEmailVerified = false
                }
            }
            return .none
        case .verifyPassword:
            let passwordRegEx = /^[a-zA-Z0-9]{8,16}$/
            
            if state.password.wholeMatch(of: passwordRegEx) != nil{
                state.passwordMessage = ""
                state.isPasswordVerified = true
            }else{
                if state.password == ""{
                    state.passwordMessage = ""
                    state.isPasswordVerified = false
                }else{
                    state.passwordMessage = "비밀번호는 8~16자리로 해주세요"
                    state.isPasswordVerified = false
                }
            }
            return .none
        case .verifyPasswordVerify:
            if state.passwordVerify == ""{
                state.passwordVerifyMessage = ""
                state.isPasswordVerifyVerified = false
            }else if state.password != state.passwordVerify{
                state.passwordVerifyMessage = "비밀번호 확인이 비밀번호와 같지 않습니다."
                state.isPasswordVerifyVerified = false
            }else if state.password == state.passwordVerify{
                state.passwordVerifyMessage = ""
                state.isPasswordVerifyVerified = true
            }
            return .none
            //에러 확인버튼 탭
        case .alertConfirmButtonTapped:
            state.isAlert = false
            return .none
        case .binding:
            return .none
        }
    }
    
}
