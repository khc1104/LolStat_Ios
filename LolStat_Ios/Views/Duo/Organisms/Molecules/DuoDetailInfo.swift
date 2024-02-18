//
//  DuoDetailInfo.swift
//  LolStat_Ios
//
//  Created by 권희철 on 2/4/24.
//

import Foundation
import SwiftUI

struct DuoDetailInfo: View {
    var duo : DuoDto
    var body: some View {
        VStack{
            DuoSummonerName(gameName: duo.gameName, tagLine: duo.tagLine, size: 24)
            Spacer()
            HStack{
                VStack{
                    Text("티어")
                        .foregroundStyle(.secondary)
                    DuoTier(tiers: [duo.tier], width: 80, height: 80)
                }
                VStack{
                    Text("찾는 티어")
                        .foregroundStyle(.secondary)
                    DuoTier(tiers: duo.wishTiers, width:80, height: 80)
                }
            }
            Text("주 포지션")
                .foregroundStyle(.secondary)
            DuoDetailPosition(lines: duo.lines, size: Const.Screen.WIDTH*0.2)
            Text("찾는 포지션")
                .foregroundStyle(.secondary)
            DuoDetailPosition(lines: duo.wishLines, size: Const.Screen.WIDTH*0.2)
            HStack{
                Text("큐 타입 : ")
                    .foregroundStyle(.secondary)
                DuoDetailQueueType()
            }
            DuoDetailRecentlyMatches(matches: duo.recentMatches)
            HStack{
                Text("메모 : ")
                    .foregroundStyle(.secondary)
                DuoMemo(memo: duo.memo)
            }
            Spacer()
        }
        .font(.kingSejong(.bold, size: 20))
    }
}

struct duodetatilpreview : PreviewProvider{
    static var previews: some View{
        DuoDetailInfo(duo: DuoDto(
            id: 704,
            userId: 2,
            gameName: "nyangoon",
            tagLine: "KR1",
            puuid: "zZYh_cAok1cTDhSY5xpadf7yWOsOiZyLWGsp-w6Jz1WljNNIvrJDTakDACD6UGcMPixFH0DfLrZSpA",
            lines: [
              Line.AD,
              Line.MID
            ],
            tier: .SILVER,
            wishLines: [
              Line.JG,
              Line.TOP
            ],
            wishTiers: [
              Tier.PLATINUM,
              Tier.GOLD
            ],
            createdAt: "2024-02-18T17:54:20.817287",
            expiredAt: "2024-02-18T18:54:20.817292",
            tickets: [],
            duoQueueId: .SOLO_RANK_GAME,
            recentMatches: [
              DuoRecentMatchDto(
                championDto: Champion(
                  name: "갈리오",
                  description: "아스라한 빛의 도시 데마시아의 성문 밖, 거대한 석상 갈리오가 경계의 눈을 늦추지 않고 서 있다. 마법사의 공격으로부터 데마시아를 수호하기 위해 만들어진 갈리오는 강력한 마법의 힘이 그를 깨울 때까지 수십 년, 때로는 수백 년 동안 한자리에 미동도 없이 서있다. 일단 깨어나면 전투의 아찔한 스릴과 데마시아인들을 구한다는 자부심을 음미하며 1분 1초도 허투루 쓰는 법이 없다. 그러나 그가 쟁취한 승리의 향기는 결코 달콤하지만은 않다. 아이러니하게도...",
                  image: "https://image.lolstat.net/champion/Galio.png"
                ),
                kills: 3,
                deaths: 3,
                assists: 6,
                win: false
              ),
              DuoRecentMatchDto(
                championDto: Champion(
                  name: "스웨인",
                  description: "제리코 스웨인은 오로지 힘만을 숭상하는 확장주의 국가 녹서스를 탁월한 예지력으로 이끄는 지도자다. 아이오니아 전쟁에서 부상을 당해 절름발이가 되고 왼팔을 잃었지만, 가차 없는 결단력으로 제국을 통치하는 자리에까지 올랐다. 악마에게 새로이 받은 왼팔과, 그 못지않게 악마 같은 수를 써서… 이제 스웨인은 최전선에서 군을 지휘하며 자신만이 볼 수 있는 어둠, 주변에 흩어진 시체에 몰려든 새까만 까마귀들에서 얼핏얼핏 목격한 광경이 다가오는 것에 대비하고...",
                  image: "https://image.lolstat.net/champion/Swain.png"
                ),
                kills: 11,
                deaths: 6,
                assists: 13,
                win: true
              ),
               DuoRecentMatchDto(
                championDto: Champion(
                  name: "조이",
                  description: "상상력과 변화의 화신인 장난꾸러기 조이는 타곤의 우주 전령으로, 세계를 뒤흔드는 중요한 사건들을 알린다. 조이는 존재만으로도 현실 세계를 지배하는 불가사의한 수학 원리를 왜곡하고, 가끔은 아무런 악의나 노력 없이도 대재앙을 일으킨다. 이것이 그녀가 자신의 의무에 경쾌하고도 태연하게 임하는 이유일지도 모른다. 조이는 장난을 치고 인간들을 골탕 먹이는 등 즐겁게 보낼 시간이 많다. 그녀를 만나면 매우 즐겁고 삶을 긍정적으로 바라보게 될 수도 있지만...",
                  image: "https://image.lolstat.net/champion/Zoe.png"
                ),
                kills: 8,
                deaths: 8,
                assists: 11,
                win: false
              ),
              DuoRecentMatchDto(
                championDto: Champion(
                  name: "오리아나",
                  description: "오리아나는 한 때 살아있는 육신을 가진 호기심 많은 소녀였지만, 이제는 전체가 시계태엽 장치로 만들어진 놀라운 기술의 산물이다. 오리아나는 자운 남부지방에서 사고를 당한 후 매우 위태로운 상황에 처했고, 다쳐서 움직일 수 없는 신체의 부분 부분이 정교한 인공 신체로 교체되었다. 오리아나는 자신을 보호하는 친구 역할을 해 주는 강력한 황동 구체와 함께, 이제 필트오버를 비롯해 온 세상에 있는 불가사의를 자유롭게 탐험한다.",
                  image: "https://image.lolstat.net/champion/Orianna.png"
                ),
                kills: 3,
                deaths: 12,
                assists: 16,
                win: true
              ),
              DuoRecentMatchDto(
                championDto: Champion(
                  name: "레나타 글라스크",
                  description: "레나타 글라스크는 어린 시절 집의 잿더미를 딛고 일어섰다. 그때 레나타가 가진 것은 이름과 부모님의 연금술 연구 자료뿐이었다. 수십 년이 지나, 레나타는 자운에서 가장 부유한 화공 남작 겸 거물 사업가가 되었다. 그녀는 모든 사람의 이해관계를 자신과 묶어서 막대한 힘을 쌓았다. 레나타와 함께하는 자는 상상 이상의 보상을 받는다. 레나타를 거스르는 자는 그 선택을 후회하며 살아간다. 하지만 결국에는 모두가 그녀의 편에 설 것이다.",
                  image: "https://image.lolstat.net/champion/Renata.png"
                ),
                kills: 2,
                deaths: 1,
                assists: 16,
                win: true
              )
            ],
            memo: "Aaaa",
            matched: false
          )
        )
    }
}

