//
//  BuyHistoryScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/08.
//

import Foundation
import SwiftUI

struct BuyHistoryScreen: View {
    
    @State var tabIndex = 0
    @EnvironmentObject var viewModel: ViewModel
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var sellerId = ""
    @State var buyerId = ""
    @State var categoryId = ""
    @State var score = 0
    @State var count = 0
    @State var wishCount = 0
    @State var chat = 0
    @State var review = false
    @State var tags = [""]
    
    @State var writer = "joo"
    @State var goodsId = ""
//    @State var score = 0
    @State var isPresentedNewGoodsReview = false
    
    @ObservedObject var userInfo = UserInfo()
//    @State var tags = [""]
    
    
    var body: some View {
        
        VStack{
         
            
            if viewModel.buyGoodsItems.count != 0 {
                List{
                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                        
                        ForEach(viewModel.buyGoodsItems.reversed(), id: \._id){ buyGoodsItem in
                            
                            
                                VStack{
                                    Divider()
                                    NavigationLink(destination: GoodsDetailViewScreen(goodsItem: buyGoodsItem), label: {
                                        Goods(title: buyGoodsItem.title, price: buyGoodsItem.price, tags: buyGoodsItem.tags, wishCount: buyGoodsItem.wishCount, chat: buyGoodsItem.chat, state: buyGoodsItem.state, image: buyGoodsItem.image)
                                    })
                                    if !buyGoodsItem.review {
                                            Button(action: {
                                                goodsId = buyGoodsItem._id
                                                isPresentedNewGoodsReview.toggle()
                                            }, label: {
                                                VStack{
                                                    HStack{
                                                        Spacer()
                                                        Image(systemName: "pencil")                                                    .foregroundColor(Color.white)
                                                        Text("후기 작성하러 가기")
                                                            .fontWeight(.bold)
                                                            .padding(.vertical)
                                                            .foregroundColor(Color.white)
                                                        
                                                        
                                                        Spacer()}
                                                }
                                                .background(Color(hex: "A9BCE8"))
                                                .cornerRadius(50)
                                            })
                                            
                            
                                    } else {
                                        NavigationLink(destination: DetailGoodsReviewScreen(goodsItem: buyGoodsItem), label: {
                                            
                                            VStack{
                                                HStack{
                                                    Spacer()
                                                    Text("작성한 후기 보러가기")
                                                        .fontWeight(.bold)
                                                        .padding(.vertical)
                                                        .foregroundColor(Color(hex: "6279B8"))
                                                    Spacer()
                                                }
                                            }
                                            .background(Color(hex: "F0F4FF"))
                                            .cornerRadius(50)
                                        })
                                    }
                                }
                                .sheet(isPresented: $isPresentedNewGoodsReview, content: {
                                    NewGoodsReviewScreen(isPresented: $isPresentedNewGoodsReview, goodsId: buyGoodsItem._id )
                                })
                         
                        }
                        
                    } onUpdate: {
                        viewModel.fetchGoodsBuyBuyerId(parameters: self.userInfo.id)
                    }
                    
                }
                .listStyle(InsetListStyle())
                .foregroundColor(Color.black)
               
            } else {
                Spacer()
                VStack{
                    Text("구매한 제품이 없습니다.")
                        .foregroundColor(Color(hex:"c4c4c4"))
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            viewModel.fetchGoodsBuyBuyerId(parameters: self.userInfo.id)
            
        })
        .navigationTitle("구매내역")
        .navigationBarBackButtonHidden(false)
    }
}
