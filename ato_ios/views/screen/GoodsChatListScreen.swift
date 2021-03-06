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
            if chatViewModel.goodsRoomItems.count > 0 {
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
                            
                        })
                            .onAppear(perform: {
                                chatViewModel.fetchGoodsRoom(goodsId: goodsItem._id)
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
    }
    else {
        VStack{
        Text("생성된 대화가 없습니다.")
                .foregroundColor(Color(hex:"c4c4c4"))
            Spacer()
        }
        
    }
        }
        .onAppear(perform: {
            chatViewModel.fetchGoodsRoom(goodsId: goodsItem._id)
            
        })
    }
    
}

