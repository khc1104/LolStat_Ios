//
//  UserStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2023/11/09.
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
        var isLoading = true
        var path = StackState<UserStore.State>()
    }
    
    /*
     액션
     */
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case searchUserInfo
        case searchButtonTapped
        case userInfoResponse(Summoner?)
        case path(StackAction<UserStore.State, UserStore.Action>)
    }
    
    /*
     리듀서
     */
    //@Dependency (\.dismiss) var dismiss
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce(self.core)
            .forEach(\.path, action: /Action.path){
                UserStore()
            }
    }
    
    @Dependency(\.lolStatAPIClient) var lolStatAPI
    func core(into state : inout State, action: Action) -> Effect<Action>{
        switch action{
            //바인딩 상태들에 관한 액션
        case .binding:
            return .none
            // 유저 정보 검색
        case .searchUserInfo:
            //state.summonerInfo = nil
            state.isLoading = true
            /*
            let successRange = 200..<300
            
            return .run { [summonerName = state.summonerName] send in
                let (data, response) = try await URLSession.shared
                    .data(from:URL(string: "\(Const.Server.ADDRESS)/summoner/\(summonerName)")!)
                
                if let httpResponse = response as? HTTPURLResponse{
                    guard successRange.contains(httpResponse.statusCode)else{
                        print("error \(httpResponse.statusCode)")
                        print(httpResponse.url!)
                        return
                    }
                    let summonerInfo = try JSONDecoder().decode(Summoner.self, from: data)
                    await send(.userInfoResponse(summonerInfo))
                    // await self.dismiss()
                }
            }
            */
            
            
            return .run { [summonerName = state.summonerName] send in
                let summonerInfo = try await lolStatAPI.requestSummonerInfoAPI(summonerName: summonerName)
                await send (.userInfoResponse(summonerInfo))
            }
             
            // 유저 정보 리스폰스 받음
        case let .userInfoResponse(summonerInfo):
            state.summonerInfo = summonerInfo
            state.isLoading = false
            //print(state.summonerInfo ?? "error")
            return .none
            
        case .searchButtonTapped:
            return .none
        case .path:
            return .none
        }
    }
}

