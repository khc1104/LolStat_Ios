//
//  UserVerifyGroup.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/28/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct UserVerifyGroup: View {
    let store : StoreOf<AccountStore>
    var body: some View {
        WithViewStore(store.self, observe: {$0}){viewStore in
            VStack{
                Form{
                    HStack{
                        VerifyCodeInput(verifycode: viewStore.$verifyCode)
                        if viewStore.timer > 0{
                            VerifyTimer(timer: viewStore.timer)
                        }else{
                            VerifyRequestButton(store : store)
                        }
                    }
                    VerifyButton()
                        .onTapGesture {
                            viewStore.send(.userVerifyButtonTapped)
                        }
                }
                Button("Logout"){
                    viewStore.send(.LogOutButtonTapped)
                }
                
            }
            .onAppear{
                viewStore.send(.onAppearTimer)
            }
            .toolbar{
                ToolbarItem{
                    Button("cancel"){
                        viewStore.send(.cancleButtonTapped)
                    }
                }
            }
        }
    }
}
/*
struct verifyPreview : PreviewProvider{
    static var previews: some View{
        UserVerifyGroup(store: Store)
    }
}
*/
