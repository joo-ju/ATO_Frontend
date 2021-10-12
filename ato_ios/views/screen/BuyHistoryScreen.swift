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
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var sellerId = "joo"
    @State var buyerId = "joo"
    @State var categoryId = ""
    @State var score = 0
    @State var count = 0
    @State var wish = 0
    @State var chat = 0
    @State var review = false
    @State var tags = [""]
    
    @State var writer = "joo"
    @State var goodsId = ""
//    @State var score = 0
    @State var isPresentedNewGoodsReview = false
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
                                    GoodsItemView(title: buyGoodsItem.title, price: buyGoodsItem.price)
                                    })
                                    if !buyGoodsItem.review {
                                    
                                        NavigationLink(destination: NewGoodsReviewScreen(isPresented: $isPresentedNewGoodsReview, writer: $writer, content: $content, goodsId: buyGoodsItem._id, score: $score, tags: $tags)){
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
                                        }
                                        //                                        .frame(width:.infinity)
                                        .background(Color(hex: "A9BCE8"))
                                        .cornerRadius(50)
                                    } else {
                                        VStack{
                                            HStack{
                                                Spacer()
                                                Text("작성한 후기 보러가기")
                                                    .fontWeight(.bold)
                                                    .padding(.vertical)
                                                    .foregroundColor(Color(hex: "A9BCE8"))
                                                
                                                
                                                Spacer()}
                                        }
                                        //                                        .frame(width:.infinity)
                                        .background(Color(hex: "F0F4FF"))
                                        .cornerRadius(50)
                                    }
                                }
                         
                        }
                        
                    } onUpdate: {
                        viewModel.fetchGoodsBuyBuyerId(parameters: buyerId)
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
            viewModel.fetchGoodsBuyBuyerId(parameters: buyerId)
            
        })
        .navigationTitle("구매내역")
        .navigationBarBackButtonHidden(false)
    }
}
