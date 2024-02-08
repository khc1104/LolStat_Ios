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
        var duoDetail : DuoDto?
    }
    enum Action{
        case requestGetDuoDetail
        case responseGetDuoDetail(DuoDetailResponse)
        
        case duoDetailOnAppear
        case cancleButtonTapped
    }
    var body: some ReducerOf<Self>{
        
        Reduce(self.core)
    }
    
    @Dependency(\.DuoAPIClient) var duoAPI
    func core(into state : inout State, action: Action) -> Effect<Action>{
        switch action{
            //
            //API Request
            //
            //듀오 디테일 GET 요청
        case .requestGetDuoDetail:
            return .run{ [id = state.duoId] send in
                if let response = try await duoAPI.requestGetDuoDetail(duoId: id){
                    await send(.responseGetDuoDetail(response))
                }else{
                    print("requestGetDuoDetailError")
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
            case .TOKEN_EXPIRED:
                return .none
            default :
                print(response.errorCode)
            }
            return .none
            
            //
            //듀오 상세페이지 액션
            //
        case .duoDetailOnAppear:
            return .run{send in
                await send(.requestGetDuoDetail)
            }
            //캔슬버튼 탭했을 때
        case .cancleButtonTapped:
            return.none
            
        }
        
    }
}
