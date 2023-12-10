//
//  User.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/16.
//

import ComposableArchitecture
import SwiftUI


struct User : View{
    let store : StoreOf<UserStore>
    
    var body : some View{
        WithViewStore(self.store, observe: {$0}){ viewStore in
            if viewStore.isLoading == false{ //로딩이 끝나면
                VStack(){
                    SummonerInfo(summonerInfo: viewStore.summonerInfo!)
                        .padding()
                    
                    VStack(){
                        ForEach(viewStore.summonerInfo!.matches){match in
                            Record(match: match)
                        }
                    }
                }
                
            }else{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
            }
        }
    }
    
}


