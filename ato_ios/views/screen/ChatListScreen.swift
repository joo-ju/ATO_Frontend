//
//  ChatListScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/26.
//

import SwiftUI

struct ChatListScreen: View {
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @State var title = ""
    
    var body: some View {
        
        VStack{
            List{
                KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                    ForEach(chatViewModel.roomItems.reversed(), id: \._id){ roomItem in
                        
                        NavigationLink(destination : FirstScreen(), label: {
                            if self.userInfo.id == roomItem.sellerId{
                                VStack{
                                Text("채팅방")
                                    Text(roomItem.customerId)
                                    Text("goodsId")
                                    Text(title)
                        //            Text(title ?? "")
                                }
                                
//                                ChatRoomItemView(userId: roomItem.customerId, goodsId: roomItem.goodsId)
                            } else {
                                
//                                ChatRoomItemView(userId: roomItem.sellerId, goodsId: roomItem.goodsId)
                            }
                            //                            GoodsItemView(title: goodsItem.title, price: goodsItem.price, tags: goodsItem.tags, wishCount: goodsItem.wishCount, chat: goodsItem.chat, state: goodsItem.state)
                        })
                            .onAppear(perform: {
                            viewModel.fetchOneGoodsId(parameters: roomItem.goodsId)
                            self.title = viewModel.oneGoodsItem?.title ?? ""
                        })
                    }
                } onUpdate: {
                    chatViewModel.fetchAllRoom()
                }
                
            }
            .onAppear(perform: {
                chatViewModel.fetchAllRoom()
                
            })
            .navigationTitle("대화 목록")
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
     
        }
    }
}
//struct ChatListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListScreen()
//    }
//}
