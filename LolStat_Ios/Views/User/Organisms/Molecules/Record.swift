//
//  Record.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/18.
//

import Foundation
import SwiftUI

struct Record : View{
    
    
    var body: some View{
        VStack{
            List{
                ForEach([Int](0...20), id: \.self){_ in 
                    Rectangle()
                        .frame(minHeight: 60)
                        .foregroundColor(Color.secondary)
                }
            }
        }
    }
}
