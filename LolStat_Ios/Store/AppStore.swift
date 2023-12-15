//
//  AppStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/12/23.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct AppStore: Reducer{
    struct State{
        @PresentationState var destination: Destination.State?
    }
    
    enum Action{
        case destination(PresentationAction<Destination.Action>)
        case searchUserInfo
    }
    
    var body: some ReducerOf<Self>{
        Reduce {state, action in
            switch action{
            case .searchUserInfo:
                return .none
            case .destination(_):
                return .none
            }
        }.ifLet(\.$destination, action: /Action.destination){
            Destination()
        }
    }
    
    struct Destination: Reducer{
        
        enum State {
            case userItem(UserStore.State)
            case mainItem(MainStore.State)
        }
        enum Action{
            case userItem(UserStore.Action)
            case mainItem(MainStore.Action)
        }
        var body : some ReducerOf<Self>{
            
            Scope(state: /State.userItem, action: /Action.userItem){
                UserStore()
            }
            Scope(state: /State.mainItem, action: /Action.mainItem){
                MainStore()
            }
        }
    }
}
