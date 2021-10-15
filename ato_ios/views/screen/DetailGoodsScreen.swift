//
//  DetailGoodsScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/14.
//  List로 보는 것이 아님..

import Foundation
import SwiftUI

struct DetailGoodsScreen: View {
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    let goodsItem: GoodsModel
    @State var price: String? //= “\(recordItem?.odometer ?? 0)”
    @State var title:String?
    @State var content = ""
//    @State var price = 0
    @State var tags = [""]
    @State var sellerId = "joo"
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                // 상단바 - 닫기, 수정
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .padding()
                })
                    .accentColor(.black)
                Spacer()
                //                Button(action: {
                //
                //                }, label: {
                NavigationLink(destination: EditGoodsDetailScreen(goodsItem: viewModel.oneGoodsItem ?? goodsItem), label: {
                    Text("수정")
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 15)
                        .foregroundColor(Color(hex: "6279B8"))
                })
                //                })
                    .accentColor(.black)
            }
            KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                //            ScrollView{
                VStack(alignment: .leading, spacing: 10) {
                    Rectangle().frame(height:0)
                    //                    if title != nil {
                    //                        Text(title ?? "")
                    Text(viewModel.oneGoodsItem?.title ?? "게시물을 가져오지 못했습니다.")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding([.top, .bottom], 10)
                    //                    }
                    Divider()
                    
                    
                    Text(viewModel.oneGoodsItem?.content ?? "게시물을 가져오지 못했습니다.")
                        .padding([.top, .bottom], 10)
                    
                        .lineSpacing(5)
                    
                    Divider()
                    
                    LazyVStack(alignment: .leading,spacing: 10){
//                        if viewModel.oneGoodsItem?.tags != nil {
//                        for text in viewModel.oneGoodsItem?.tags ?? ["default value"] {
//                            if chips.isEmpty{
//                                chips.append([])
//                            }
//                            print("Chips : ", chips)
//                            print("chips.count : ", chips.count)
//                            print("text: ", text)
//                            print("tags: ", tags)
//                            print("_id: ", goodsItem._id)
//
//                            chips[chips.count-1].append(ChipData(chipText: text, idx: idx))
//                            idx = idx + 1
//
//                        }
//
//                        }
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
            // end of ScrollView
            
            
        onUpdate:{
            viewModel.fetchOneGoodsId(parameters:goodsItem._id)
            
            self.title = viewModel.oneGoodsItem?.title
            self.tags = viewModel.oneGoodsItem?.tags ?? ["default value"]
//            self.price = viewModel.oneGoodsItem?.price ?? 0
            
            self.price = "\(viewModel.oneGoodsItem?.price ?? 0)"
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
//                Text(price ?? "")
                    .fontWeight(.bold)
                Spacer()
                Button(action:{ }, label: {
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
            } // end of HStack
            .frame(height: 50, alignment: .center)
            .padding([.leading, .trailing], 15)
            .padding(.leading, 5)
            
        } // end of VStack
        .navigationBarHidden(true)
        .onAppear(perform: {
            //            self.title = goodsItem.title
            //            self.content = goodsItem.content
            //            self.price = goodsItem.price
            //            self.tags = goodsItem.tags
            
            viewModel.fetchOneGoodsId(parameters: goodsItem._id)
            self.title = viewModel.oneGoodsItem?.title
//            self.tags = viewModel.oneGoodsItem?.tags ?? ["default value"]
//            self.price = viewModel.oneGoodsItem?.price ?? 0
            self.price = "\(viewModel.oneGoodsItem?.price ?? 0)"
   
        })
    }
}
