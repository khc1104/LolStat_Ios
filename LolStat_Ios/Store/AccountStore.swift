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
        @BindingState var passwordVerify : String = ""
        var emailMessage = ""
        var passwordMessage = ""
        var passwordVerifyMessage = ""
        
    }
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case joinButtonTapped
        case verifyEmail
        case verifyPassword
        case verifyPasswordVerify
    }
    var body : some ReducerOf<Self>{
        BindingReducer()
        
        Reduce(self.joinAcountReducer)
    }
    
    func joinAcountReducer(into state : inout State, action: Action) -> Effect<Action>{
        switch action{
            //회원가입 버튼 눌렀을 때
        case .joinButtonTapped:
            
            return .none
        
        case .verifyEmail:
            let emailRegEx = /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/
            if let emailMatch = state.email.wholeMatch(of: emailRegEx){
                state.emailMessage = ""
            }else{
                if state.email == ""{
                    state.emailMessage = ""
                }else{
                    state.emailMessage = "이메일 형식에 맞게 써주세요"
                }
            }
            return .none
        case .verifyPassword:
            let passwordRegEx = /^[a-zA-Z0-9]{8,16}$/
            
            if let passwordMatch = state.password.wholeMatch(of: passwordRegEx){
                state.passwordMessage = ""
            }else{
                if state.password == ""{
                    state.passwordMessage = ""
                }else{
                    state.passwordMessage = "비밀번호는 8~16자리로 해주세요"
                }
            }
            return .none
        case .verifyPasswordVerify:
            if state.passwordVerify == ""{
                state.passwordVerifyMessage = ""
            }else if state.password != state.passwordVerify{
                state.passwordVerifyMessage = "비밀번호 확인이 비밀번호와 같지 않습니다."
            }else if state.password == state.passwordVerify{
                state.passwordVerifyMessage = ""
            }
            return .none
        case .binding:
            return .none
        }
    }
    
}
