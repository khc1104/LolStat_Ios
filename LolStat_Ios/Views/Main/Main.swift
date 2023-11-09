//
//  Main.swift
//  valorant_project
//
//  Created by 권희철 on 2023/10/06.
//

import Foundation
import SwiftUI


struct Main: View {
    var body: some View{
        VStack{
            NavigationView{
                Search()
            }
        }
    }
}

struct Main_Preview: PreviewProvider{
    static var previews: some View{
        Main()
    }
}
