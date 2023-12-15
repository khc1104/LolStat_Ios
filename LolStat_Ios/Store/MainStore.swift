//
//  MainStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/11/23.
//

import Foundation
import ComposableArchitecture


//
//메인 화면에서 사용 할 Store
//
struct MainStore : Reducer{
    /*
     상태
     */
    struct State : Equatable{
        @BindingState var summonerName: String = ""
        @PresentationState var userStore : UserStore.State?
        
    }
    
    /*
     액션
     */
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case searchButtonTapped
        case userStore(PresentationAction<UserStore.Action>)
        
    }
    
    /*
     리듀서
     */
    //@Dependency (\.dismiss) var dismiss
    var body: some ReducerOf<Self>{
        BindingReducer()

        
        Reduce { state, action in
            switch action{
            case .binding: //바인딩 상태들을 수정함
                return .none
            case .searchButtonTapped:
                return .none
            //case .userStore(.presented(.searchUserInfo(summonerName: state.summonerName))):
              //  guard let summonerInfo = state.userStore?.summonerInfo
                //else { return .none}
                
                //return .none
            case .userStore:
                return .none
            }
        }
        .ifLet(\.$userStore, action: /Action.userStore){
            UserStore()
        }
    }
}
