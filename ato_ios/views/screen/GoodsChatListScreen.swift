//
//  GoodsChatListScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/26.
//

import SwiftUI
import Foundation



struct GoodsChatListScreen: View {
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    let goodsItem: GoodsModel
    var userItems: [UserRegisterModel] = []
    @State var title = ""
    @State var lastMsgIdx = 0
    var body: some View {
        VStack(spacing: 10) {
            
            List{
                KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                    ForEach(chatViewModel.goodsRoomItems.reversed(), id: \._id){ roomItem in
                        NavigationLink(destination : DialogScreen(goodsId: goodsItem._id, sellerId: goodsItem.sellerId, roomId: roomItem._id ?? ""), label: {
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
                                            //
                                        }
                                        else {
                                            //                                                { print(chatViewModel.contentItems.count)}
                                            Text(chatViewModel.contentItems[lastMsgIdx].message)
                                                .padding(.top, 3)
                                                .lineLimit(1)
                                            //                                                    .padding(.leading, 13)
                                                .onAppear(perform: {
                                                    lastMsgIdx = chatViewModel.contentItems.count - 1
                                                    print("== 채팅 갯수 : ", chatViewModel.contentItems.count)
                                                })
                                        }
                                        
                                    }
                                    //                                        .padding(.leading, 3)
                                }
                                Spacer()
                                Rectangle().frame(width: 50, height: 50)
                                
                                    .background(Color(hex:"0000000"))
                                    .cornerRadius(5)
                            }
                            .padding(.top, 2)
                            
                            .onAppear(perform: {
                                userViewModel.fetchOneUser(parameters: roomItem.customerId)
                                viewModel.fetchOneGoodsId(parameters: roomItem.goodsId)
                                self.title = viewModel.oneGoodsItem?.title ?? ""
                                chatViewModel.fetchChat(roomId: roomItem._id, goodsId: roomItem.goodsId)
                                
                                print("채팅 갯수 : ", chatViewModel.contentItems)
                            })
                            
                            //                                ChatRoomItemView(userId: roomItem.customerId, goodsId: roomItem.goodsId)
                            
                            //                            GoodsItemView(title: goodsItem.title, price: goodsItem.price, tags: goodsItem.tags, wishCount: goodsItem.wishCount, chat: goodsItem.chat, state: goodsItem.state)
                        })
                            .onAppear(perform: {
                                chatViewModel.fetchGoodsRoom(goodsId: goodsItem._id)
                                //                        viewModel.fetchOneGoodsId(parameters: roomItem.goodsId)
                                //                        self.title = viewModel.oneGoodsItem?.title ?? ""
                            })
                    }
                } onUpdate: {
                    chatViewModel.fetchAllRoom()
                }
                
            }
            .listStyle(InsetListStyle())
            .onAppear(perform: {
                chatViewModel.fetchAllRoom()
                
            })
            .navigationTitle("대화 목록")
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
            //      Button("Go back", action: { presentationMode.wrappedValue.dismiss() })
        }
        .onAppear(perform: {
            //                    userViewModel.fetchOneUser(parameters: "616579dee6a40292c0bcab6a")
            chatViewModel.fetchGoodsRoom(goodsId: goodsItem._id)
            //                viewModel.fetchOneGoodsId(parameters: goodsItem._id)
            
        })
    }
    
}

