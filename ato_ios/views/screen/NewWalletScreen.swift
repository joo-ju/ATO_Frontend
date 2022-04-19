//
//  NewWalletScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/31.
//

import SwiftUI

struct NewWalletScreen: View {
    
    @ObservedObject var userInfo = UserInfo()
    var body: some View {
        VStack{
            Text("Hello world")
        }
        .navigationTitle("지갑생성")
    }
}

struct NewWalletScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewWalletScreen()
    }
}
