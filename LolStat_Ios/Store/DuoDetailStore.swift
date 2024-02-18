//
//  DuoDetailStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/6/24.
//

import Foundation
import ComposableArchitecture

struct DuoDetailStore: Reducer{
    struct State : Equatable{
        var duoId : Int = 0
        var myDuoId : Int = 0
        var duoDetail : DuoDto?
        var isLogin : Bool = true
        
        
        @BindingState var gameName : String = ""
        @BindingState var tagLine : String = ""
        @BindingState var position : [Line: Bool] = [Line.TOP : false, Line.JG : false, Line.MID : false, Line.AD : false, Line.SUP : false]
        @BindingState var memo : String = ""
        
        var runningRequest : DuoRequest?
        @PresentationState var accountStore : AccountStore.State?
        
    }
    enum Action : BindableAction{
        case requestGetDuoDetail
        case requestPostDuoTicket
        case requestPostDuoTicketAccept(Int)
        
        case responseGetDuoDetail(DuoDetailResponse)
        case responsePostDuoTicket(AuthResponse)
        case responsePostDuoTicketAccept(AuthResponse)
        
        case duoDetailOnAppear
        case cancleButtonTapped
        case acceptButtonTapped(Int)
        case createButtonTapped
        
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
    func core(into state : inout State, action: Action) -> Effect<Action>{
        switch action{
            //
            //API Request
            //
            //듀오 디테일 GET 요청
        case .requestGetDuoDetail:
            state.runningRequest = .GET_DUO_DETAIL
            return .run{ [id = state.duoId] send in
                if let response = try await duoAPI.requestGetDuoDetail(duoId: id){
                    await send(.responseGetDuoDetail(response))
                }else{
                    print("requestGetDuoDetailError")
                }
            }
            //듀오 티켓 생성 요청
        case .requestPostDuoTicket:
            var position : [Line] = []
            state.position.forEach{ pos in
                if pos.value{
                    position.append(pos.key)
                }
            }
            let ticketRequest = AddDuoTicketRequest(gameName: state.gameName, tagLine: state.tagLine, lines: position, memo: state.memo)
            
            return .run{[id = state.duoId, ticket = ticketRequest] send in
                if let response = try await duoAPI.requestPostDuoTicket(ticket: ticket, duoId: id){
                    await send(.responsePostDuoTicket(response))
                }else{
                    print("requestPostDuoTicket Error")
                }
            }
            //듀오 티켓 수락 POST 요청
        case let .requestPostDuoTicketAccept(ticketId):
            return .run{[ticketId = ticketId, duoId = state.duoId] send in
                if let response = try await duoAPI.requestPostDuoTicketAccept(duoId: duoId, ticketId: ticketId){
                    await send(.responsePostDuoTicketAccept(response))
                }else{
                    print("requestPostDuoTicket Error")
                }
            }
            //
            //API Response
            //
            //듀오 디테일 GET 반환
        case let .responseGetDuoDetail(response):
            switch response.errorCode{
            case .NO_ERROR:
                state.duoDetail = response.duo
                state.accountStore = nil
            case .TOKEN_EXPIRED:
                state.accountStore = AccountStore.State()
                return .none
            default :
                print(response.errorCode)
            }
            return .none
            
            //듀오 티켓 POST 반환
        case let .responsePostDuoTicket(response):
            switch response.errorCode{
            case .NO_ERROR:
                return .run{ send in
                    await send(.requestGetDuoDetail)
                }
            case .TOKEN_EXPIRED:
                print("토큰 만료")
                return .none
            default:
                print(response.message)
                return .none
            }
            // 듀오 티켓 수락 POST 반환
        case let .responsePostDuoTicketAccept(response):
            switch response.errorCode{
            case .NO_ERROR:
                return .run{send in
                    await send(.requestGetDuoDetail)
                }
            default:
                print(response.message)
                return .none
            }
            //
            //듀오 상세페이지 액션
            //
            //듀오 상세페이지 onAppear
        case .duoDetailOnAppear:
            return .run{send in
                await send(.requestGetDuoDetail)
            }
            //캔슬버튼 탭했을 때
        case .cancleButtonTapped:
            return.none
            //신청 수락 버튼 탭
        case let .acceptButtonTapped(ticketId):
            return .run{[ticketId = ticketId] send in
                await send(.requestPostDuoTicketAccept(ticketId))
            }
            //티켓 신청 버튼 탭
        case .createButtonTapped:
            return .run{ send in
                await send(.requestPostDuoTicket)
            }
        case .accountStore(.presented(.responseRefreshToken)):
            guard let isLogin = state.accountStore?.isLogin else{
                print("ResponseRefreshToken failed")
                return .none
            }
            if isLogin{
                switch state.runningRequest {
                case .GET_DUO_DETAIL:
                    return .run{send in
                        await send(.requestGetDuoDetail)
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
