//
//  DuoStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/3/24.
//

import Foundation
import ComposableArchitecture

struct DuoStore: Reducer{
    struct State : Equatable{
        var myduo : DuoDto?
        var duoList: [DuoDto]?
        var duoDetail : DuoDto?
        @BindingState var isDetail : Bool = false
        var page : Int = 1
        var match : String = "ALL"
        var queue : String = "ALL"
        
        var isLogin : Bool = true
        var isAccessToken : Bool = true
        @PresentationState var accountStore : AccountStore.State?
        
    }
    enum Action: BindableAction{
        case requestGetDuoList
        case requestGetDuoDetail(Int)
        case responseGetDuoList(DuoListResponse)
        case responseCantGetDuoList
        case responseGetDuoDetail(DuoDetailResponse)
        
        
        case duoOnAppear
        case logOutButtonTapped
        case duoInfoTapped(Int)
        case duoDetailCancleTapped
        
        case accountStore(PresentationAction<AccountStore.Action>)
        case binding(BindingAction<State>)
    }
    var body : some ReducerOf<Self>{
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
            //듀오리스트 요청
        case .requestGetDuoList:
            
            return .run{ [page = state.page, match = state.match, queue = state.queue]send in
                if let response = try await duoAPI.requestGetDuoList(page: page, match: match, queue: queue){
                    await send(.responseGetDuoList(response))
                }else{
                    print("requestGetDuoListError")
                    await send(.responseCantGetDuoList)
                }
            }
            //듀오 디테일 요청
        case let .requestGetDuoDetail(id):
            return .run{[id = id]send in
                if let response = try await duoAPI.requestGetDuoDetail(duoId: id){
                    await send(.responseGetDuoDetail(response))
                }else{
                    print("requestGetDuoDetailError")
                    //await send()
                }
            }
            //
            //API Response
            //
            //듀오리스트 반환
        case let .responseGetDuoList(response):
            switch response.errorCode{
            case .NO_ERROR:
                state.duoList = response.duoList
                state.myduo = response.myDuo
                state.isLogin = true
                state.isAccessToken = true
                state.accountStore = nil
            case .TOKEN_EXPIRED:
                state.isAccessToken = false
                //state.accountStore = AccountStore.State()
            default:
                print(response.errorCode)
            }
            return .none
            //듀오리스트 refeshToken만료 혹은 불량일 때 반환
        case .responseCantGetDuoList:
            state.isLogin = false
            state.isAccessToken = false
            state.accountStore = AccountStore.State()
            return .none
            //듀오 디테일 반환
        case let .responseGetDuoDetail(response):
            switch response.errorCode{
            case .NO_ERROR:
                state.duoDetail = response.duo
            case .TOKEN_EXPIRED:
                state.isAccessToken = false
                state.accountStore = AccountStore.State()
            default:
                print(response.errorCode)
            }
            return .none
            //
            //듀오페이지 액션
            //
        case .duoOnAppear:
            
            return .run{send in
                await send(.requestGetDuoList)
            }
        case .logOutButtonTapped:
            KeyChain.delete(key: "AccessToken")
            KeyChain.delete(key: "RefreshToken")
            state.isLogin = false
            state.isAccessToken = false
            return .run{send in
                await send(.requestGetDuoList)
            }
            //듀오카드 눌렀을 때
        case let .duoInfoTapped(id):
            state.isDetail = true
            return .run{[id = id]send in
                await send(.requestGetDuoDetail(id))
            }
            
        case .accountStore(.presented(.responseRefreshToken)):
            guard let isLogin = state.accountStore?.isLogin else{
                print("ResponseRefreshToken failed")
                return .none
            }
            if isLogin{
                print("토큰 정상발급")
                return .run{send in
                    await send(.requestGetDuoList)
                }
            }else{
                print("만료 or 비정상 토큰")
            }
            state.isLogin = isLogin
            //state.accountStore = nil
            return .none
            //
            //듀오디테일 액션
            //
            //캔슬버튼 눌렀 을 때
        case .duoDetailCancleTapped:
            state.isDetail = false
            state.duoDetail = nil
            return .none
            //
            //Presected 액션
            //
        case .accountStore(.presented(.responseLogin)):
            guard let isLogin = state.accountStore?.isLogin else{
                print("ResponseLogin failed")
                return .none
            }
            if isLogin{
                print("로그인")
                return .run{send in
                    await send(.requestGetDuoList)
                }
            }else{
                print("로그인 실패")
            }
            state.isLogin = isLogin
            //state.accountStore = nil
            return .none
        case .accountStore:
            return .none
        case .binding:
            return .none
        }
        
    }
    
}
