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
        
    }
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case joinButtonTapped
        case verifyEmail
        case verifyPassword
        case verifyPasswordVerify
        case reqeustCreateUser
        
        case responseCreateUser(Bool)
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
            let createAccount = CreateUserRequest(email: state.email,
                                                  password: state.password,
                                                  passwordCheck: state.passwordVerify)
            return .run{ send in
                let isCreated = try await accountAPI.requestCreateUser(user: createAccount)
                await send(.responseCreateUser(isCreated))
            }
            
            //
            //API Response
            //
        case let .responseCreateUser(isCreated):
            if isCreated == true{
                print("생성됨")
            }else{
                print("생성 실패")
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
        case .binding:
            return .none
        }
    }
    
}
