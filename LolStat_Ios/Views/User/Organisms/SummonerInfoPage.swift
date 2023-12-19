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
    let summonerInfo : Summoner
    var body: some View{
        ScrollView(){
            SummonerInfo(profile: summonerInfo.profile)
                .padding()
            VStack(){
                ForEach(summonerInfo.matches){match in
                    Record(match: match)
                }
            }
        }
    }
}
