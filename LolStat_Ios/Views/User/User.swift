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
                if(viewStore.summonerInfo == nil){
                    Text("존재하지 않는 소환사입니다")
                    //TODO: 존재하지 않는 소환사 페이지
                }
                ScrollView(){
                    SummonerInfo(profile: viewStore.summonerInfo!.profile)
                        .padding()
                    
                    VStack(){
                        ForEach( viewStore.summonerInfo!.matches){match in
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

struct Preview_User: PreviewProvider{
    static var previews: some View{
        User(store: .init(
            initialState: .init(),
            reducer:{
                UserStore()
                    ._printChanges()
            }
            )
        )
    }
}
