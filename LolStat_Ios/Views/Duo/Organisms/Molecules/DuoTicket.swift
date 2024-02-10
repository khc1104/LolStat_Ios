//
//  DuoTicket.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/8/24.
//

import Foundation
import SwiftUI

struct DuoTicket:View {
    let ticket : DuoTicketDto
    var body: some View {
        VStack{
            HStack{
                DuoTicketSummonerName(gameName: ticket.gameName, tagLine: ticket.tagLine)
            }
            HStack{
                DuoTier(tiers: [ticket.tier])
                DuoTicketPosition(positions:ticket.lines)
                DuoTicketRecentlyChampions(matches: ticket.recentMatches)
            }
            HStack{
                DuoMemo(memo: ticket.memo)
            }
            HStack{
                DuoDate(date: ticket.createdAt)
            }
        }
        .frame(width: Const.Screen.WIDTH)
        .background(Color.indigo)
    }
}
/*
struct DuoTicketPreview : PreviewProvider{
    static var previews: some View{
        DuoTicket()
    }
}
*/
