//
//  GoodsChatUserListScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/30.
// 구매자를 선정하기 위한 홤

import Foundation
import SwiftUI
import Alamofire

struct GoodsChatUserListScreen: View {

    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    let goodsItem: GoodsModel
    var userItems: [UserRegisterModel] = []
    @State var title = ""
    @State var lastMsgIdx = 0
    @State var buyerId = ""
    @State var send: Date = Date()
    @State var format1 = "yyyy년 MM월 dd일"
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 10) {
            if chatViewModel.goodsRoomItems.count > 0 {
            List{
                KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {

                    ForEach(chatViewModel.goodsRoomItems.reversed(), id: \._id){ roomItem in
                        Button(action: {
                            buyerId = roomItem.customerId
                            print(buyerId)
                            let parameters = ["id": roomItem.goodsId, "buyerId": buyerId]
                            viewModel.updateBuyerId(parameters: parameters)
                            viewModel.fetchOneGoodsId(parameters: roomItem.goodsId)
                            presentationMode.wrappedValue.dismiss()
                        }, label:{
                            HStack(alignment:.center){
                                HStack{
                                    Circle().frame(width: 50, height: 50)
                                        .foregroundColor(Color.gray)
                                    VStack(alignment:.leading ,spacing: 0){
                                        HStack{
                                            Text(userViewModel.oneUserItem?.username ?? "")
                                                .font(.system(size: 20))
                                                .fontWeight(.bold)
                                                .padding(.leading, 5)
                                            Spacer()
                                        
                                        Spacer()
                                        if  chatViewModel.contentItems.count == 0{
                                            
                                            Text("")
                                                .padding(.top, 1)
                                        }
                                        else {
                                            Text(send.toString(format: "yyyy년 MM월 dd일")!)
                                                .font(.system(size: 15))
                                                .padding(.top, 3)
                                                .lineLimit(1)
                                                .foregroundColor(Color.gray)
                                                .onAppear(perform: {
                                                    lastMsgIdx = chatViewModel.contentItems.count - 1
                                                    print("== 채팅 갯수 : ", chatViewModel.contentItems.count)
                                                    send = chatViewModel.contentItems[lastMsgIdx].sendTime.toDate(format: format1) ?? Date()
                                                    print(send)
                                                    print(send.toString(format: "yyyy년 MM월 dd일")!)
                                                    
                                                })
                                        }
                                        }


                                    }
                                }
                                Spacer()
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
            .navigationTitle("구매자 선택")
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)

        
    }
    else {
        VStack{
        Text("대화한 사람이 없습니다.")
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

