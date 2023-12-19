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
        var path = StackState<UserStore.State>()
        //@PresentationState var userStore = UserStore.State()
    }
    
    /*
     액션
     */
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case searchButtonTapped
        case path(StackAction<UserStore.State, UserStore.Action>)
        //case userStore(PresentationAction<UserStore.Action>)
    }
    
    /*
     리듀서
     */
    //@Dependency (\.lolStatAPIClient) var lolStatAPI
    var body: some ReducerOf<Self>{
        BindingReducer()
        
        Reduce { state, action in
            switch action{
            case .binding: //바인딩 상태들을 수정함
                return .none
            case .searchButtonTapped:
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path){
            UserStore()
        }

    }
}
