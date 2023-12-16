//
//  Pasing.swift
//  LolStat_Ios
//
//  Created by 권희철 on 12/15/23.
//

import Foundation

struct Moc{
    let summonerData : Summoner = JsonReader<Summoner>.loadData(from: "response1")!

    class JsonReader<T> where T: Decodable {
        static func loadData(from file: String) -> T? {
            do {
                if let filePath = Bundle.main.path(forResource: file, ofType: "json") {
                    let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                    let results = try JSONDecoder().decode(T.self, from: data)
                    return results
                }
            } catch {
                print("Error: \(error)")
            }

            return nil
        }
    }
}
