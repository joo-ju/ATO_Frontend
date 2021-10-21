//
//  DialogScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/22.
//

import SwiftUI

struct DialogScreen: View {
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatViewModel: ChatService
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    //    @State var roomItem: RoomModel
    
    let goodsId: String
    let sellerId: String
    
    var body: some View {
        VStack{
            Text("채팅방 _id")
            Text(chatViewModel.roomItem?._id ?? "")
        }
        .onAppear(perform: {
            print("\n\ngoodsId", goodsId)
            print("sellerId", sellerId)
            
            let parameters: [String:Any] = ["sellerId" : sellerId, "customerId": self.userInfo.id, "goodsId": goodsId]
            
            chatViewModel.createRoom(parameters: parameters)
            chatViewModel.joinRoom(parameters: parameters)
        })
    }
}

