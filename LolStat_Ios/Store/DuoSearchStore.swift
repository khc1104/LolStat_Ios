//
//  DuoSearchStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/11/24.
//

import Foundation
import ComposableArchitecture

struct DuoSearchStore: Reducer{
    struct State : Equatable{
        @BindingState var gameName : String = ""
        @BindingState var tagLine : String = ""
        @BindingState var mainPosition : [Line : Bool] = [Line.TOP : false, Line.JG : false, Line.MID : false, Line.AD : false, Line.SUP : false]
        @BindingState var wishPosition : [Line : Bool] = [Line.TOP : false, Line.JG : false, Line.MID : false, Line.AD : false, Line.SUP : false]
        @BindingState var wishTier : [Tier : Bool] = [Tier.UNRANKED : false, Tier.IRON : false, Tier.BRONZE : false, Tier.SILVER : false, Tier.GOLD : false, Tier.PLATINUM : false, Tier.EMERALD : false, Tier.DIAMOND : false, Tier.MASTER : false, Tier.GRANDMASTER : false, Tier.CHALLENGER : false ]
        @BindingState var queueId : DuoQueueId = .SOLO_RANK_GAME
        @BindingState var memo : String = ""
        
        var isLogin : Bool = true
        var runningRequest : DuoRequest?
        @PresentationState var accountStore : AccountStore.State?
        
    }
    enum Action : BindableAction{
        case requestPostDuo
        
        case responsePostDuo(AuthResponse)
        case cancleButtonTapped
        case searchButtonTapped
        
        case accountStore(PresentationAction<AccountStore.Action>)
        case binding(BindingAction<State>)
    }
    var body: some ReducerOf<Self>{
        BindingReducer()
        
        Reduce(self.core)
            .ifLet(\.$accountStore, action: /Action.accountStore){
                AccountStore()
            }
    }
    
    @Dependency(\.DuoAPIClient) var duoAPI
    func core(into state: inout State, action: Action) -> Effect<Action>{
        switch action{
            //
            //API Request
            //
        case .requestPostDuo:
            state.runningRequest = .POST_DUO
            var mainPosition : [Line] = []
            var wishPosition : [Line] = []
            var wishTier : [Tier] = []
            state.mainPosition.forEach{ position in
                if position.value{
                    mainPosition.append(position.key)
                }
            }
            state.wishPosition.forEach{ position in
                if position.value{
                    wishPosition.append(position.key)
                }
            }
            state.wishTier.forEach{ tier in
                if tier.value{
                    wishTier.append(tier.key)
                }
            }
            let requestDuo = AddDuoRequest(gameName: state.gameName, tagLine: state.tagLine, lines: mainPosition, wishLines: wishPosition, wishTiers: wishTier, duoQueueId: state.queueId, memo: state.memo)
            
            return .run{ [requestDuo = requestDuo] send in
                if let response = try await duoAPI.requestPostDuo(duo: requestDuo){
                    await send(.responsePostDuo(response))
                }else{
                    print("reqeustPostDuo Error")
                }
            }
            //
            //API Response
            //
        case let .responsePostDuo(response):
            switch response.errorCode{
            case .NO_ERROR:
                //print("글쓰기 성공")
                state.isLogin = true
                state.accountStore = nil
                return .none
            case .TOKEN_EXPIRED:
                state.accountStore = AccountStore.State()
                return .none
            default:
                print(response.errorCode)
                return .none
            }
            
            //
            //페이지 액션
            //
            //찾기 버튼 탭
        case .searchButtonTapped:
            return .run{ send in
                await send(.requestPostDuo)
            }
        case .cancleButtonTapped:
            return .none
            //
            //Present 액션
            //
        case .accountStore(.presented(.responseRefreshToken)):
            guard let isLogin = state.accountStore?.isLogin else{
                print("ResponseRefreshToken failed")
                return .none
            }
            if isLogin{
                switch state.runningRequest {
                case .POST_DUO_DETAIL:
                    return .run{send in
                        await send(.requestPostDuo)
                    }
                default:
                    return .none
                }
            }else{
                state.isLogin = false
                state.accountStore = nil
            }
            return .none
        case .accountStore:
            return .none
        case .binding:
            return .none
        }
    }
}
