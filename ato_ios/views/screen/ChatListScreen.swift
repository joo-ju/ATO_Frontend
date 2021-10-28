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
    @EnvironmentObject var userViewModel: UserViewModel
    @State var title = ""
    @State var sample = RoomModel(_id: "", sellerId: "", customerId: "", goodsId: "", isDeleted: false)
    @State var lastMsgIdx = 0
    var body: some View {
        VStack(spacing: 10) {
            
            List{
                KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                    ForEach(userViewModel.userHistoryItem?.chatRooms.reversed() ?? [sample], id: \._id){ roomItem in
                        NavigationLink(destination : DialogScreen(goodsId: roomItem.goodsId, sellerId: roomItem.sellerId, roomId: roomItem._id ?? ""), label: {
                            HStack(alignment:.center){
                                HStack{
                                    Circle().frame(width: 50, height: 50)
                                        .foregroundColor(Color.gray)
                                
                                    VStack(alignment:.leading ,spacing: 0){
                                        HStack{
                                            Text(userViewModel.oneUserItem?.username ?? "")
                                                .fontWeight(.bold)
                                                .padding(0)
                                            //                                                .background(Color.yellow)
                                            Text("10월 2일")
                                                .font(.system(size: 15))
                                                .foregroundColor(Color.gray)
                                            
                                            Spacer()
                                        }
                                        Spacer()
                                        if  chatViewModel.contentItems.count == 0{
                                            Text("대화를 시작하세요!")
                                                .padding(.top, 1)
                                        }
                                        else {
                                            Text(chatViewModel.contentItems[lastMsgIdx].message)
                                                .padding(.top, 3)
                                                .lineLimit(1)
                                                .onAppear(perform: {
                                                    lastMsgIdx = chatViewModel.contentItems.count - 1
                                                    print("== 채팅 갯수 : ", chatViewModel.contentItems.count)
                                                })
                                        }
                                    }
                                    Spacer()
                                    Rectangle().frame(width: 50, height: 50)
                                        .background(Color(hex:"0000000"))
                                        .cornerRadius(5)
                               
                              
                            }                            .padding(.top, 2)

                            }})
                            .onAppear(perform: {
                                userViewModel.fetchOneUser(parameters: roomItem.sellerId)
                                
                                viewModel.fetchOneGoodsId(parameters: roomItem.goodsId)
                                chatViewModel.fetchChat(roomId: roomItem._id, goodsId: roomItem.goodsId)
                        
                            })
                    }
                } onUpdate: {
                    chatViewModel.fetchAllRoom()
                }
                
            }
            .listStyle(InsetListStyle())
            .onAppear(perform: {
            })
        }
    }
}
