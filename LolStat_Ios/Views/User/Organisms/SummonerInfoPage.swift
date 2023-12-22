//
//  SummonerInfoPage.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/18/23.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct SummonerInfoPage: View{
    let profile : Profile
    let matches : [SimpleMatch]
    
    var body: some View{
        
        ScrollView(){
            SummonerInfo(profile: profile)
                .padding()
            VStack(){
                ForEach(matches){match in
                    MatchInfo(match: match)
                }
            }
        }
    }
}
