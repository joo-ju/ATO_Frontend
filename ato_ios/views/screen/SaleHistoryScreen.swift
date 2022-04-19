//
//  SaleHistoryScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/08.
//  판매 내역 화면 -> 판매중, 판매 완료, 숨김

import Foundation

import SwiftUI

struct SaleHistoryScreen: View {
    
    @State var tabIndex = 0
    var body: some View {
        VStack{
            SaleHistoryTabbar(tabIndex: $tabIndex)
            if tabIndex == 0 {
                SaleTab()
            }
            else if tabIndex == 1{
                SoldTab()
            }
            else {
                HidingTab()
            }
        }
        
        .navigationTitle("판매내역")
        .navigationBarBackButtonHidden(false)
    }
    
}


struct SaleTab: View {
    
    @State var tabIndex = 0
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var userInfo = UserInfo()
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var sellerId = "joo"
    @State var buyerId = ""
    @State var categoryId = ""
    @State var score = 0
    @State var count = 0
    @State var wishCount = 0
    @State var chat = 0
    @State var review = false
    @State var tags = [""]
    
    var body: some View {
        
        VStack{
            
            if viewModel.saleGoodsItems.count != 0 {
                List{
                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                        
                        ForEach(viewModel.saleGoodsItems.reversed(), id: \._id){ saleGoodsItem in
                            
                            NavigationLink(destination: GoodsDetailViewScreen(goodsItem: saleGoodsItem), label: {
                                Goods(title: saleGoodsItem.title, price: saleGoodsItem.price, tags: saleGoodsItem.tags, wishCount: saleGoodsItem.wishCount, chat: saleGoodsItem.chat, state: saleGoodsItem.state, image: saleGoodsItem.image)
                            })
                        }
                        
                    } onUpdate: {
                        viewModel.fetchGoodsSaleSellerId(parameters: sellerId)
                    }
                    
                }
                .listStyle(InsetListStyle())
                .foregroundColor(Color.black)
            } else {
                Spacer()
                VStack{
                    Text("판매중인 게시물이 없습니다.")
                        .foregroundColor(Color(hex:"c4c4c4"))
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            viewModel.fetchGoodsSaleSellerId(parameters: self.userInfo.id)
        })
        
    }
    
}
struct SoldTab: View {
    
    @State var tabIndex = 0
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var userInfo = UserInfo()
    
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var sellerId = ""
    @State var buyerId = ""
    @State var categoryId = ""
    @State var score = 0
    @State var count = 0
    @State var wish = 0
    @State var chat = 0
    @State var review = false
    @State var tags = [""]
    
    var body: some View {
        
        VStack{
            if viewModel.soldGoodsItems.count != 0 {
                List{
                    
                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                        
                        ForEach(viewModel.soldGoodsItems.reversed(), id: \._id){ soldGoodsItem in
                            
                            NavigationLink(destination: DetailGoodsScreen(goodsItem: soldGoodsItem), label: {
                                Goods(title: soldGoodsItem.title, price: soldGoodsItem.price, tags: soldGoodsItem.tags, wishCount: soldGoodsItem.wishCount, chat: soldGoodsItem.chat, state: soldGoodsItem.state, image: soldGoodsItem.image)
                            })
                        }
                        
                    } onUpdate: {
                        viewModel.fetchGoodsSoldSellerId(parameters: sellerId)
                    }
                    
                }
                .listStyle(InsetListStyle())
                .foregroundColor(Color.black)
            } else {
                Spacer()
                VStack{
                    Text("판매완료된 게시물이 없습니다.")
                        .foregroundColor(Color(hex:"c4c4c4"))
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            viewModel.fetchGoodsSoldSellerId(parameters: self.userInfo.id)
        })
        
    }
    
    
}
struct HidingTab: View {
    @State var tabIndex = 0
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var sellerId = "joo"
    @State var buyerId = ""
    @State var categoryId = ""
    @State var score = 0
//    @State var count = 0
    @State var wishCount = 0
    @State var chat = 0
    @State var review = false
    @State var tags = [""]
    
    var body: some View {
        
        VStack{
            
            if viewModel.hidingGoodsItems.count != 0 {
                List{
                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                        
                        ForEach(viewModel.hidingGoodsItems.reversed(), id: \._id){ hidingGoodsItem in
                            
                            NavigationLink(destination: GoodsDetailViewScreen(goodsItem: hidingGoodsItem), label: {
                                Goods(title: hidingGoodsItem.title, price: hidingGoodsItem.price, tags: hidingGoodsItem.tags, wishCount: hidingGoodsItem.wishCount, chat: hidingGoodsItem.chat, state: hidingGoodsItem.state, image: hidingGoodsItem.image)
                            })
                        }
                        
                    } onUpdate: {
                        viewModel.fetchGoodsHidingSellerId(parameters: sellerId)
                    }
                    
                }
                .listStyle(InsetListStyle())
                .foregroundColor(Color.black)
            } else {
                Spacer()
                VStack{
                    Text("숨긴 게시물이 없습니다.")
                        .foregroundColor(Color(hex:"c4c4c4"))
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            viewModel.fetchGoodsHidingSellerId(parameters: sellerId)
        })
        
    }
}
