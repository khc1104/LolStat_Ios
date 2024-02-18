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
        .background(.defaultBackground)
        .foregroundColor(.white)
    }
}

struct DuoTicketPreview : PreviewProvider{
    static var previews: some View{
        DuoTicket(ticket: DuoTicketDto(
                      id: 1119,
                       userId: 452,
                       duoId: 702,
                       gameName: "nyangoon",
                       tagLine: "KR1",
                       lines: [
                          Line.TOP
                       ],
                       tier: .SILVER,
                       memo: "[Web발신]너는나를존중해야한다.나는최고의...[더보기]",
                       createdAt: "2024-02-15T20:28:46",
                       recentMatches: [
                         DuoRecentMatchDto(
                           championDto: Champion(
                             name: "조이",
                             description: "상상력과 변화의 화신인 장난꾸러기 조이는 타곤의 우주 전령으로, 세계를 흔드는 중요한 사건들을 알린다. 조이는 존재만으로도 현실 세계를 지배하는 불가사의한 수학 원리를 왜곡하고, 가끔은 아무런 악의나 노력 없이도 대재앙을 일으킨다. 이것이 그녀가 자신의 의무에 경쾌하고도 태연하게 임하는 이유일지도 모른다. 조이는 장난을 치고 인간들을 골탕 먹이는 등 즐겁게 보낼 시간이 많다. 그녀를 만나면 매우 즐겁고 삶을 긍정적으로 바라보게 될 수도 있지만...",
                             image: "https://image.lolstat.net/champion/Zoe.png"
                           ),
                           kills: 13,
                           deaths: 7,
                           assists: 6,
                           win: false
                         ),DuoRecentMatchDto(
                            championDto: Champion(
                              name: "조이",
                              description: "상상력과 변화의 화신인 장난꾸러기 조이는 타곤의 우주 전령으로, 세계를 흔드는 중요한 사건들을 알린다. 조이는 존재만으로도 현실 세계를 지배하는 불가사의한 수학 원리를 왜곡하고, 가끔은 아무런 악의나 노력 없이도 대재앙을 일으킨다. 이것이 그녀가 자신의 의무에 경쾌하고도 태연하게 임하는 이유일지도 모른다. 조이는 장난을 치고 인간들을 골탕 먹이는 등 즐겁게 보낼 시간이 많다. 그녀를 만나면 매우 즐겁고 삶을 긍정적으로 바라보게 될 수도 있지만...",
                              image: "https://image.lolstat.net/champion/Zoe.png"
                            ),
                            kills: 13,
                            deaths: 7,
                            assists: 6,
                            win: false
                          ),DuoRecentMatchDto(
                            championDto: Champion(
                              name: "조이",
                              description: "상상력과 변화의 화신인 장난꾸러기 조이는 타곤의 우주 전령으로, 세계를 흔드는 중요한 사건들을 알린다. 조이는 존재만으로도 현실 세계를 지배하는 불가사의한 수학 원리를 왜곡하고, 가끔은 아무런 악의나 노력 없이도 대재앙을 일으킨다. 이것이 그녀가 자신의 의무에 경쾌하고도 태연하게 임하는 이유일지도 모른다. 조이는 장난을 치고 인간들을 골탕 먹이는 등 즐겁게 보낼 시간이 많다. 그녀를 만나면 매우 즐겁고 삶을 긍정적으로 바라보게 될 수도 있지만...",
                              image: "https://image.lolstat.net/champion/Zoe.png"
                            ),
                            kills: 13,
                            deaths: 7,
                            assists: 6,
                            win: false
                          ),DuoRecentMatchDto(
                            championDto: Champion(
                              name: "조이",
                              description: "상상력과 변화의 화신인 장난꾸러기 조이는 타곤의 우주 전령으로, 세계를 흔드는 중요한 사건들을 알린다. 조이는 존재만으로도 현실 세계를 지배하는 불가사의한 수학 원리를 왜곡하고, 가끔은 아무런 악의나 노력 없이도 대재앙을 일으킨다. 이것이 그녀가 자신의 의무에 경쾌하고도 태연하게 임하는 이유일지도 모른다. 조이는 장난을 치고 인간들을 골탕 먹이는 등 즐겁게 보낼 시간이 많다. 그녀를 만나면 매우 즐겁고 삶을 긍정적으로 바라보게 될 수도 있지만...",
                              image: "https://image.lolstat.net/champion/Zoe.png"
                            ),
                            kills: 13,
                            deaths: 7,
                            assists: 6,
                            win: false
                          ),DuoRecentMatchDto(
                            championDto: Champion(
                              name: "조이",
                              description: "상상력과 변화의 화신인 장난꾸러기 조이는 타곤의 우주 전령으로, 세계를 흔드는 중요한 사건들을 알린다. 조이는 존재만으로도 현실 세계를 지배하는 불가사의한 수학 원리를 왜곡하고, 가끔은 아무런 악의나 노력 없이도 대재앙을 일으킨다. 이것이 그녀가 자신의 의무에 경쾌하고도 태연하게 임하는 이유일지도 모른다. 조이는 장난을 치고 인간들을 골탕 먹이는 등 즐겁게 보낼 시간이 많다. 그녀를 만나면 매우 즐겁고 삶을 긍정적으로 바라보게 될 수도 있지만...",
                              image: "https://image.lolstat.net/champion/Zoe.png"
                            ),
                            kills: 13,
                            deaths: 7,
                            assists: 6,
                            win: false
                          ),
                       ]
        )
        )
    }
}

