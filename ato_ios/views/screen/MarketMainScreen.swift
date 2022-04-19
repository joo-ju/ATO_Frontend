//
//  MainMarket.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/15.
//  중고거래 메인화면

import Foundation
import SwiftUI

struct MarketMain : View {
    
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @State var isPresentedNewPost = false
    
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var tags = [""]
    @State var sellerId = ""
    @State var buyerId = ""
    @State var categoryId = ""
    @State var count = 0
    @State var score = 0
    @State var wishCount = 0
    
    @State var wishGoods = [""]
    @State var userId = ""
    
    @State var chat = 0
    @State var review = false
    
    @State var keyword = ""
    
    var body: some View {
        ZStack{
            // 전체 화면 색상 변경
            Color(hex: "C3D3FE").edgesIgnoringSafeArea(.all)
            
          
            VStack(spacing: 15){
                // 검색바
                
                // GoodsMainBar
                VStack{
                    TextField("검색어를 입력해주세요.", text: $keyword)
                        .padding()
                        .padding(.leading, 10)
                        .background(Color(hex: "F0F4FF"))
                        .clipShape(RoundedRectangle(cornerRadius: 50), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                    
                } // end VStack
                .padding([.leading, .trailing], 10)
                .padding(.top, 20)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                // end GoodsMainBar
                
                // 상품 목록
                if keyword == "" {
                    List{
                        
                        KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                            ForEach(viewModel.goodsItems.reversed(), id: \._id){ goodsItem in
                                
                                NavigationLink(destination: DetailGoodsScreen(goodsItem: goodsItem), label: {
                                    
                                    Goods(title: goodsItem.title, price: goodsItem.price, tags: goodsItem.tags, wishCount: goodsItem.wishCount, chat: goodsItem.chat, state: goodsItem.state, image: goodsItem.image)
                                    
                                })
                            }
                        } onUpdate: {
                            viewModel.fetchAllGoods()
                            
                            userViewModel.fetchUserHistory(parameters: self.userInfo.id)
                        }
                        
                    }
                    .onAppear {
                        UITableView.appearance().separatorStyle = .none
                    }
                    .listStyle(InsetListStyle())
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 40)
                    
                }
                else {
                    List{
                        ForEach(viewModel.goodsItems.filter({$0.title.contains(keyword) }), id: \._id){ goodsItem in
                            
                            NavigationLink(destination: DetailGoodsScreen(goodsItem: goodsItem), label: {
                                Goods(title: goodsItem.title, price: goodsItem.price, tags: goodsItem.tags, wishCount: goodsItem.wishCount, chat: goodsItem.chat, state: goodsItem.state)
                                
                            })
                        }
                    }
                    .listStyle(InsetListStyle())
                }
            }
            .sheet(isPresented: $isPresentedNewPost, content: {
                NewGoodsScreen(isPresented: $isPresentedNewPost, title: $title, content: $content, price: $price, tags: $tags, sellerId: $sellerId, buyerId: $buyerId, categoryId: $categoryId, count: $count, score: $score, wishCount: $wishCount, chat: $chat, review: $review)
            })
            .onAppear(perform: {
                viewModel.fetchAllGoods()
                userViewModel.fetchUserHistory(parameters: self.userInfo.id)
            })
            Spacer()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: NewGoodsScreen(isPresented: $isPresentedNewPost, title: $title, content: $content, price: $price, tags: $tags, sellerId: $sellerId, buyerId: $buyerId, categoryId: $categoryId, count: $count, score: $score, wishCount: $wishCount, chat: $chat, review: $review)){
                        plusButton
                    }// end Navigation Link
                    
                    
                }
                Text("")
                    .padding(.vertical, 20)
            }
        }// end ZStack
    } // end View
    
    
    var plusButton: some View {
        Button(action: {
            isPresentedNewPost.toggle()
        }, label: {
            Image(systemName: "plus")
                .frame(width: 60, height: 60)
                .foregroundColor(Color.white)
                .background(Color(hex:"6279B8"))
                .cornerRadius(38.5)
                .padding()
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
        })
    }
    
}
