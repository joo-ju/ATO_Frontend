//
//  EditAccountScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/12.
//  계정 정보 수정할 것. 

import SwiftUI

struct EditAccountScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        VStack{
            
        }
        .onAppear(perform: {
            
        })
        .navigationTitle("계정정보")
        .navigationBarBackButtonHidden(false)
    }
}

struct EditAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountScreen()
    }
}
