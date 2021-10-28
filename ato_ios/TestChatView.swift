////
////  TestChatView.swift
////  ato_ios
////
////  Created by 김주희 on 2021/10/16.
////
//
import Foundation
import SwiftUI
public struct DetailGoodsScreen1: View {
 
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    let goodsItem: GoodsModel
    let goodsUserItems: [UserRegisterModel] = []
    @State var price: String?
    @State var title:String?
    @State var content = ""
    @State var tags = [""]
    @State var sellerId = ""
    @State var customerId = ""
    @State var buyerId = ""
    @State var categoryId = ""
    @State var score = 0
    @State var count = 0
    @State var wishCount = 0
    @State var chat = 0
    @State var review = false
    @State var idx = 0
    @State var chips : [[ChipData]] = []
    @State var isWished = false
    
    @State var GoodsChatListScreenActive = false
//    public init() {}
    
  public var body: some View {
      VStack(alignment: .leading, spacing: 10) {
          KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
              VStack(alignment: .leading, spacing: 10) {
                  Rectangle().frame(height:0)
                  Text(viewModel.oneGoodsItem?.title ?? "게시물을 가져오지 못했습니다.")
                      .fontWeight(.bold)
                      .font(.system(size: 20))
                      .padding([.top, .bottom], 10)
                  Divider()
                  
                  
                  Text(viewModel.oneGoodsItem?.content ?? "게시물을 가져오지 못했습니다.")
                      .padding([.top, .bottom], 10)
                  
                      .lineSpacing(5)
                  
                  Divider()
                  
                  LazyVStack(alignment: .leading,spacing: 10){
                      // Since Were Using Indices So WE Need To Specify Id....
                      ForEach(chips.indices,id: \.self){index in
                          
                          HStack{
                              
                              // some times it asks us to specify hashable in Data Model...
                              ForEach(chips[index].indices,id: \.self){chipIndex in
                                  MarketTag(tag:chips[index][chipIndex].chipText)
                                  // Main Logic......
                                      .overlay(
                                          
                                          GeometryReader{reader -> Color in
                                              
                                              // By Using MaxX Parameter We Can Use Logic And Determine if its exceeds or not....
                                              
                                              let maxX = reader.frame(in: .global).maxX
                                              
                                              // Both Paddings  = 30+ 30 = 60
                                              // Plus 10 For Extra....
                                              
                                              // Doing Action Only If The Item Exceeds...
                                              
                                              if maxX > UIScreen.main.bounds.width - 70 && !chips[index][chipIndex].isExceeded{
                                                  
                                                  // It is updating to each user interaction....
                                                  
                                                  DispatchQueue.main.async {
                                                      
                                                      // Toggling That...
                                                      chips[index][chipIndex].isExceeded = true
                                                      
                                                      // Getting Last Item...
                                                      let lastItem = chips[index][chipIndex]
                                                      // removing Item From Current Row...
                                                      // inserting it as new item...
                                                      chips.append([lastItem])
                                                      chips[index].remove(at: chipIndex)
                                                      
                                                  }
                                              }
                                              
                                              return Color.clear
                                          },
                                          alignment: .trailing
                                      )
                                      .clipShape(Capsule())
                              }
                          }
                      }
                  }
                  
                  Spacer()
                  
              } // end of VStack
              .padding([.leading, .trailing], 20)
              
          }
      onUpdate:{
          viewModel.fetchOneGoodsId(parameters:goodsItem._id)
          
          self.title = viewModel.oneGoodsItem?.title
          self.tags = viewModel.oneGoodsItem?.tags ?? ["default value"]
          
          self.price = "\(viewModel.oneGoodsItem?.price ?? 0)"
          self.chips  = []
          for text in tags {
              if chips.isEmpty{
                  chips.append([])
              }
              print("Chips : ", chips)
              print("chips.count : ", chips.count)
              print("text: ", text)
              print("tags: ", tags)
              print("_id: ", goodsItem._id)
              
              chips[chips.count-1].append(ChipData(chipText: text, idx: idx))
              idx = idx + 1
              
          }
          print(chips)
      }
          HStack{
              Button(action:{
                  // 찜 했던 Goods를 취소
                  if isWished == true {
                      isWished = false
                      userViewModel.deleteUserHistoryWish(parameters: ["userId": self.userInfo.id, "goodsId": goodsItem._id])
                  }
                  // 새로운 Goods를 찜
                  else {
                      isWished = true
                      userViewModel.createUserHistoryWish(parameters: ["userId": self.userInfo.id, "goodsId": goodsItem._id])
                      
                  }
              }, label: {
                  if isWished {
                      Image(systemName: "heart.fill")
                          .resizable()
                          .frame(width:20, height: 15)
                          .foregroundColor(Color(hex: "A9BCE8"))
                  } else {
                      Image(systemName: "heart")
                          .resizable()
                          .frame(width:20, height: 15)
                          .foregroundColor(Color(hex: "c4c4c4"))
                  }
              })
                  .onAppear(perform: {
                      // userHistory 조회해서 찜 했는지 안했는지 확인
                      if ((userViewModel.userHistoryItem?.wishGoods.contains(goodsItem._id)) == true) {
                          
                          isWished = true
                      }
                  })
              Divider()
                  .padding(.leading, 5)
                  .padding(.trailing, 5)
              Text("\(viewModel.oneGoodsItem?.price ?? 0 )원")
            
                  .fontWeight(.bold)
              Spacer()
              if goodsItem.sellerId == self.userInfo.id {
                  HStack{
                      NavigationLink(destination: SecondScreen()) {
                          HStack{
                                                Text("채팅 목록 보기")
                                                    .fontWeight(.bold)
                                            }
                                            .frame(width: 120)
                                            .padding(10)
                                            .background(Color(hex: "A9BCE8"))
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                      }
//                      NavigationLink(
//                        destination: SecondScreen()
////                          destination: GoodsChatListScreen(goodsItem: goodsItem),
////                          isActive: $GoodsChatListScreenActive,
//                          label: {
//                          HStack{
//                              Text("채팅 목록 보기")
//                                  .fontWeight(.bold)
//                          }
//                          .frame(width: 120)
//                          .padding(10)
//                          .background(Color(hex: "A9BCE8"))
//                          .cornerRadius(10)
//                          .foregroundColor(.white)
//
//                      })
//
//                        Button(action:{
////                            self.viewRouter.currentPage = "page2"
//                            self.isLinkActiveList = true
//
////                                presentationMode.wrappedValue.dismiss()
////                            chatViewModel.fetchGoodsRoom(goodsId: goodsItem._id)
//
//
//                        }, label: {
//                            HStack{
//                                Text("채팅 목록 보기")
//                                    .fontWeight(.bold)
//                            }
//                            .frame(width: 120)
//                            .padding(10)
//                            .background(Color(hex: "A9BCE8"))
//                            .cornerRadius(10)
//                            .foregroundColor(.white)
//
//                        })
                  }
//                    .background(NavigationLink(destination: GoodsChatListScreen(goodsItem: goodsItem), isActive: $isLinkActiveList){
//
//                    }
//                                    .hidden()
//                    )
              }
              else {
                  HStack{
                      Button(action: {
//                          self.isLinkActive = true
                          
                      }, label: {
                          
                          HStack{
                              Image(systemName: "envelope.fill")
                                  .resizable()
                                  .frame(width:20, height: 15)
                                  .foregroundColor(Color(hex: "ffffff"))
                                  .padding(.trailing, 10)
                              Text("대화하기")
                                  .fontWeight(.bold)
                          }
                          .frame(width: 120)
                          .padding(10)
                          .background(Color(hex: "A9BCE8"))
                          .cornerRadius(10)
                          .foregroundColor(.white)
                      })
                  }
//                  .background(NavigationLink(destination: DialogScreen(goodsId: goodsItem._id, sellerId: goodsItem.sellerId, roomId: chatViewModel.roomItem?._id ?? "")
////                                             , isActive: $isLinkActive
//                                            ){
//
//                  }
//                                  .hidden()
//                  )
              }
          } // end of HStack
          .frame(height: 50, alignment: .center)
          .padding([.leading, .trailing], 15)
          .padding(.leading, 5)
          
          
//      List {
//        row
//        row
//        row
//      }
    
      
  } // end of VStack
  
  .onAppear(perform: {
      self.tags = [""]
      self.tags = goodsItem.tags
      self.chips  = []
      for text in tags {
          
          if chips.isEmpty{
              chips.append([])
          }
          print("Chips : ", chips)
          print("chips.count : ", chips.count)
          print("text: ", text)
          print("tags: ", tags)
          print("_id: ", goodsItem._id)
          
          chips[chips.count-1].append(ChipData(chipText: text, idx: idx))
          idx = idx + 1
          
      }
      viewModel.fetchOneGoodsId(parameters: goodsItem._id)
      self.title = viewModel.oneGoodsItem?.title
      self.price = "\(viewModel.oneGoodsItem?.price ?? 0)"

      let parameters: [String:Any] = ["sellerId" : goodsItem.sellerId, "customerId": self.userInfo.id, "goodsId": goodsItem._id]
      if goodsItem.sellerId != self.userInfo.id {
          chatViewModel.createRoom(parameters: parameters)
          
          chatViewModel.fetchRoom(sellerId: goodsItem.sellerId, goodsId: goodsItem._id, customerId: self.userInfo.id)
      }
      else if goodsItem.sellerId == self.userInfo.id {

//                userViewModel.fetchOneUser(parameters: "616579dee6a40292c0bcab6a")
          
      }
      
  })
  .navigationBarHidden(true)
  }
  private var row: some View {
    NavigationLink(destination: SecondScreen()) {
      Text("Row")
    }
  }
}
//struct TestChatView: View {
//    @ObservedObject var service = ChatService()
//    @State var msg = ""
//    var body: some View {
//        VStack{
//            Text("Received messages from NodeJS : ")
//                .font(.title)
//            ScrollView{
//            ForEach(service.messages, id: \.self) { msg in
//                Text(msg)
//                    .padding()
//              
//            }.onAppear(perform: {
//                
//            })
//                Spacer()}
//            HStack{
//                TextField("Enter Message...", text: $msg)
//                    .padding()
//                Button(action: {
////                    service.messssages.append(msg)
////                    service.sendMessage(message: msg)
//             
//                    msg = ""
//                }, label: {
//                    Image(systemName: "paperplane")
//                        .padding()
//                        .background(Color.gray)
//                })
//            }
//            .background(Color.yellow)
//            .padding(.bottom, 40)
//           
//      
//        }
//    }
//}
