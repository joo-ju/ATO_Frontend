//
//  GoodsChatListScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/26.
//

import SwiftUI

struct GoodsChatListScreen: View {
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    let goodsItem: GoodsModel
//    @State var title = ""
//    @State var goodsId = ""
    
    var body: some View {
        
        VStack{
            ScrollView{
                ForEach(chatViewModel.goodsRoomItems.reversed(), id: \._id){ roomItem in
                    VStack{
//                    Text(roomItem.goodsId)
                        Text(goodsItem.title)
                        Text(roomItem.customerId)
//                    ChatRoomItemView(userId: roomItem.customerId, goodsId: roomItem.goodsId)
                    }
                    .onAppear(perform: {
//                        chatViewModel.fetchGoodsRoom(goodsId: roomItem.goodsId)
                    })
                    
                }
            }
            .onAppear(perform: {
                
            })
            .navigationTitle("대화 목록")
            .navigationBarHidden(false)
            
        }
    }
}
