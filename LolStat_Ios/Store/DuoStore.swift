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
        @BindingState var selectedView : TabViewState = .MAIN
        
        var myduo : DuoDto?
        var duoList: [DuoDto]?
        //var duoDetail : DuoDto?
        @BindingState var isDetail : Bool = false
        @BindingState var selectedMatch : DuoIsMatch = .ALL
        @BindingState var selectedQueue : DuoQueueId = .ALL
        var page : Int = 1
        var match : String = "ALL"
        var queue : String = "ALL"
        
        var isLogin : Bool = false
        var emailAuth  : Bool = true
        var isAccessToken : Bool = true
        var runningRequest : DuoRequest?
        @PresentationState var accountStore : AccountStore.State?
        
        @PresentationState var duoDetailStore : DuoDetailStore.State?
        @PresentationState var duoSearchStore : DuoSearchStore.State?
        
        @BindingState var isAlert : Bool  = false
        var alertMessage : String = ""
    }
    enum Action: BindableAction{
        case requestGetDuoList
        //case requestGetDuoDetail(Int)
        case responseGetDuoList(DuoListResponse)
        case responseCantGetDuoList
       // case responseGetDuoDetail(DuoDetailResponse)
        
        
        case duoOnAppear
        case duoListSearchButtonTapped
        case logOutButtonTapped
        case duoInfoTapped(Int)
        case duoSearchButtonTapped
        case duoDetailCancleTapped
        case alertConfirmButtonTapped
        
        case accountStore(PresentationAction<AccountStore.Action>)
        case duoDetailStore(PresentationAction<DuoDetailStore.Action>)
        case duoSearchStore(PresentationAction<DuoSearchStore.Action>)
        case binding(BindingAction<State>)
        
        case duoSearchActivateAlert
    }
    var body : some ReducerOf<Self>{
        BindingReducer()
        
        Reduce(self.core)
            .ifLet(\.$accountStore, action: /Action.accountStore){
                AccountStore()
            }
            .ifLet(\.$duoDetailStore, action: /Action.duoDetailStore){
                DuoDetailStore()
            }
            .ifLet(\.$duoSearchStore, action: /Action.duoSearchStore){
                DuoSearchStore()
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
            state.runningRequest = .GET_DUO
            return .run{ [page = state.page, match = state.selectedMatch.rawValue, queue = state.selectedQueue.rawValue]send in
                if let response = try await duoAPI.requestGetDuoList(page: page, match: match, queue: queue){
                    await send(.responseGetDuoList(response))
                }else{
                    print("requestGetDuoListError")
                    await send(.responseCantGetDuoList)
                }
            }
            //듀오 디테일 요청
            /*
        case let .requestGetDuoDetail(id):
            return .run{[id = id]send in
                if let response = try await duoAPI.requestGetDuoDetail(duoId: id){
                    await send(.responseGetDuoDetail(response))
                }else{
                    print("requestGetDuoDetailError")
                    //await send()
                }
            }
             */
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
                state.accountStore = AccountStore.State()
            case .NEED_EMAIL_AUTHENTICATION:
                state.isLogin = true
                state.emailAuth = false
                state.accountStore = AccountStore.State()
            default:
                print(response.errorCode)
            }
            //state.accountStore = nil
            return .none
            //듀오리스트 refeshToken만료 혹은 불량일 때 반환
        case .responseCantGetDuoList:
            state.isLogin = false
            state.isAccessToken = false
            state.accountStore = AccountStore.State()
            //state.accountStore = nil
            return .none
            //듀오 디테일 반환
            /*
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
             */
            //
            //듀오페이지 액션
            //
        case .duoOnAppear:
            return .run{send in
                await send(.requestGetDuoList)
            }
            //카테고리 선택 후 검색 기능
        case .duoListSearchButtonTapped:
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
            let myDuoId = state.myduo?.id ?? 0
            state.duoDetailStore = DuoDetailStore.State(
                duoId: id,
                myDuoId: Int(myDuoId)
            )
            return .none
            //듀오 찾기 버튼 탭
        case .duoSearchButtonTapped:
            state.duoSearchStore = DuoSearchStore.State()
            return .none
            //에러메세지 확인버튼 탭
        case .alertConfirmButtonTapped:
            state.isAlert = false
            return .none
            //
            //듀오디테일 액션
            //
            //캔슬버튼 눌렀 을 때
        case .duoDetailCancleTapped:
            state.isDetail = false
            state.duoDetailStore = nil
            return .none
            
            //
            //Presented 액션
            //
            //어카운트 로그인 반환
        case .accountStore(.presented(.responseLogin)):
            guard let isLogin = state.accountStore?.isLogin else{
                print("ResponseLogin failed")
                return .none
            }
            if isLogin{
                state.selectedView = .DUO
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
            //어카운트 - 리프레쉬 토큰 반환
        case .accountStore(.presented(.responseRefreshToken)):
            print("dd")
            guard let isLogin = state.accountStore?.isLogin else{
                print("ResponseRefreshToken failed")
                return .none
            }
            print("dd")
            print(isLogin)
            if isLogin{
                switch state.runningRequest {
                case .GET_DUO:
                    return .run{send in
                        await send(.requestGetDuoList)
                    }
                default:
                    return .none
                }
            }else{
                state.isLogin = false
                state.isAccessToken = false
            }
            return .none
            //어카운트  - 캔슬 버튼 탭
        case .accountStore(.presented(.cancleButtonTapped)):
            state.accountStore = nil
            state.selectedView = .MAIN
            return .none
        case.accountStore(.presented(.responseUserVerify)):
            guard let isVerify = state.accountStore?.isVerified else{
                print("emailVerify failed")
                return .none
            }
            if isVerify{
                state.accountStore = nil
                return .run{send in
                    await send(.requestGetDuoList)
                }
            }else{
                return .none
            }
            //듀오상세 - 리프레쉬토큰
        case .duoDetailStore(.presented(.accountStore)):
            guard let isLogin = state.duoDetailStore?.isLogin else{
                print("DuoDetailRefreshToken failed")
                return .none
            }
            if isLogin{
                return .none
            }else{
                state.isLogin = false
                state.isAccessToken = false
                state.duoDetailStore = nil
                state.accountStore = AccountStore.State()
                return .none
            }
            //듀오상세 - 캔슬 버튼 탭
        case .duoDetailStore(.presented(.cancleButtonTapped)):
            state.duoDetailStore = nil
            return .none
            
            //듀오 찾기 - 듀오 생성시
        case .duoSearchStore(.presented(.responsePostDuo)):
            guard let errorCode = state.duoSearchStore?.errorCode else{
                print("DuoDetailRefreshToken failed")
                return .none
            }
            switch errorCode{
            case .NO_ERROR:
                state.duoSearchStore = nil
                return .run{send in
                    await send(.requestGetDuoList)
                }
            case .TOKEN_EXPIRED:
                return .none
            case .DUO_ALREADY_EXIST:
                state.duoSearchStore = nil
                return .run{send in
                    await send(.duoSearchActivateAlert)
                }
            default:
                print(errorCode)
                return .none
            }
            //듀오서치 - 리프레쉬 토큰
        case .duoSearchStore(.presented(.accountStore)):
            guard let isLogin = state.duoSearchStore?.isLogin else{
                print("DuoDetailRefreshToken failed")
                return .none
            }
            if isLogin{
                return .none
            }else{
                state.isLogin = false
                state.isAccessToken = false
                state.duoDetailStore = nil
                state.accountStore = AccountStore.State()
                return .none
            }
        case .duoSearchStore(.presented(.cancleButtonTapped)):
            state.duoSearchStore = nil
            return .none
            
            
        case .accountStore:
            return .none
        case .duoDetailStore:
            return .none
            
        case .duoSearchStore:
            return .none
        case .binding:
            return .none
            
        case .duoSearchActivateAlert:
            state.isAlert = true
            state.alertMessage = "이미 등록한 듀오 찾기가 존재합니다."
            return .none
        }
        
        
    }
    
}
