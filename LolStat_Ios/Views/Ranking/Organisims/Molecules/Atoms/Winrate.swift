//
//  Winrate.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/28/23.
//

import Foundation
import SwiftUI

struct Winrate : View {
    let wins : Int32
    let loses: Int32
    var body: some View {
        HStack(spacing: 0){
            ZStack{
                Text("\(wins)W")
                    .foregroundStyle(.white)
            }
            .frame(width:Const.Screen.WIDTH
                    * getWinsRate(wins: wins, loses: loses))
            .background(.blue)
            ZStack{
                Text("\(loses)L")
                    .foregroundStyle(.white)
            }
            .frame(width:Const.Screen.WIDTH
                    * getlosesRate(wins: wins, loses: loses))
            .background(.pink)
        }
        
    }
}


func getWinsRate(wins: Int32, loses: Int32) -> CGFloat{
    let total = Float(wins+loses)
    let winsRate = (Float(wins)/total)
    return CGFloat(winsRate)
}
func getlosesRate(wins: Int32, loses: Int32) -> CGFloat{
    let total = Float(wins + loses)
    let losesRate = (Float(loses)/total)
    return CGFloat(losesRate)
}

