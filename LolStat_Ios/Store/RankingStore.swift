//
//  RankingStore.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/11/23.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct RankingStore: Reducer{
    struct State{
        
    }
    
    enum Action{
        
    }
    var body: some ReducerOf<Self>{
        Reduce{ state, action in
            //TODO : 랭킹 관련 행동들 
            return .none
        }
    }
}
