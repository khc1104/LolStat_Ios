//
//  UserStore.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/26.
//

import Foundation
import ComposableArchitecture

struct UserStore : Reducer{

    /*
     상태
     */
    struct State : Equatable{
        @BindingState var summonerName : String = ""
        var summonerInfo : Summoner?
        var isLoading = false
        
    }
    
    /*
     액션
     */
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case searchUserInfo
        case UserInfoResponse(Summoner)
        
    }
    
    /*
     리듀서
     */
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce(self.core)
        
    }
    
    func core(into state : inout State, action: Action) -> Effect<Action>{
        switch action{
            // 유저 정보 검색
        case .searchUserInfo:
            state.summonerInfo = nil
            state.isLoading = true
            
            return .run { [summonerName = state.summonerName] send in
                let (data, _) = try await URLSession.shared
                    .data(from:URL(string: "\(Const.Server.ADDRESS)/summoner/\(summonerName)")!)
                let summonerInfo = try JSONDecoder().decode(Summoner.self, from: data)
                await send(.UserInfoResponse(summonerInfo))
            }
            // 유저 정보 리스폰스 받음
        case let .UserInfoResponse(summonerInfo):
            state.summonerInfo = summonerInfo
            state.isLoading = false
            print(state.summonerInfo ?? "error")
            return .none
            
            //바인딩 상태들에 관한 액션
        case .binding:
            return .none
        }
        
        
        
    }
    
}
