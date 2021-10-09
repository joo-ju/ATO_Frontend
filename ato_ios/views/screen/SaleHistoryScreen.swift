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
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var sellerId = "joo"
    @State var buyerId = ""
    @State var categoryId = ""
    @State var score = 0
    @State var count = 0
    @State var tags = [""]
    
    var body: some View {
   
            VStack{
                
                if viewModel.saleGoodsItems.count != 0 {
                List{
                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                    
                        ForEach(viewModel.saleGoodsItems.reversed(), id: \._id){ saleGoodsItem in
                            
                            NavigationLink(destination: GoodsDetailViewScreen(goodsItem: saleGoodsItem), label: {
                                
                                VStack(alignment: .leading){
                                    HStack{
                                        Rectangle().frame(width: 110, height: 120)
                                            .background(Color(hex: "C4C4C4"))
                                            .cornerRadius(20)
                                            .padding(.trailing, 7)
                                        
                                        VStack(alignment: .leading){
                                            Text(saleGoodsItem.title)
                                                .font(.system(size: 15))
                                            //                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                .padding(.bottom, 3)
                                            Text("3분전")
                                                .font(.system(size: 13))
                                                .foregroundColor(Color(hex: "828282"))
                                            HStack{
                                                MarketTag(tag: "EXIT")
                                                MarketTag(tag: "앨범")
                                            }// end HStack
                                            HStack(alignment: .bottom){
                                                Text("\(saleGoodsItem.price)")
                                                    .font(.system(size: 16))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                //                        .padding(.top, 10)
                                                Spacer()
                                                HStack(spacing:2){
                                                    Image(systemName: "suit.heart")
                                                        .resizable()
                                                        .frame(width:15, height: 13)
                                                    Text("10")
                                                        .font(.system(size: 14))
                                                        .padding(.trailing, 5)
                                                    Image(systemName: "message")
                                                        .resizable()
                                                        .frame(width:15, height: 13)
                                                    Text("4")
                                                        .font(.system(size: 14))
                                                        .padding(.trailing, 7)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
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
                viewModel.fetchGoodsSaleSellerId(parameters: sellerId)
            })
    
    }
    
}
struct SoldTab: View {
    
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
    @State var count = 0
    @State var tags = [""]
    
    var body: some View {
   
            VStack{
                if viewModel.soldGoodsItems.count != 0 {
                List{
                   
                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                    
                        ForEach(viewModel.soldGoodsItems.reversed(), id: \._id){ soldGoodsItem in
                            
                            NavigationLink(destination: GoodsDetailViewScreen(goodsItem: soldGoodsItem), label: {
                                
                                VStack(alignment: .leading){
                                    HStack{
                                        Rectangle().frame(width: 110, height: 120)
                                            .background(Color(hex: "C4C4C4"))
                                            .cornerRadius(20)
                                            .padding(.trailing, 7)
                                        
                                        VStack(alignment: .leading){
                                            Text(soldGoodsItem.title)
                                                .font(.system(size: 15))
                                            //                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                .padding(.bottom, 3)
                                            Text("3분전")
                                                .font(.system(size: 13))
                                                .foregroundColor(Color(hex: "828282"))
                                            HStack{
                                                MarketTag(tag: "EXIT")
                                                MarketTag(tag: "앨범")
                                            }// end HStack
                                            HStack(alignment: .bottom){
                                                Text("\(soldGoodsItem.price)")
                                                    .font(.system(size: 16))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                //                        .padding(.top, 10)
                                                Spacer()
                                                HStack(spacing:2){
                                                    Image(systemName: "suit.heart")
                                                        .resizable()
                                                        .frame(width:15, height: 13)
                                                    Text("10")
                                                        .font(.system(size: 14))
                                                        .padding(.trailing, 5)
                                                    Image(systemName: "message")
                                                        .resizable()
                                                        .frame(width:15, height: 13)
                                                    Text("4")
                                                        .font(.system(size: 14))
                                                        .padding(.trailing, 7)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
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
                viewModel.fetchGoodsSoldSellerId(parameters: sellerId)
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
    @State var count = 0
    @State var tags = [""]
    
    var body: some View {
   
            VStack{
                
                    if viewModel.hidingGoodsItems.count != 0 {
                List{
                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                    
                        ForEach(viewModel.hidingGoodsItems.reversed(), id: \._id){ hidingGoodsItem in
                            
                            NavigationLink(destination: GoodsDetailViewScreen(goodsItem: hidingGoodsItem), label: {
                                
                                VStack(alignment: .leading){
                                    HStack{
                                        Rectangle().frame(width: 110, height: 120)
                                            .background(Color(hex: "C4C4C4"))
                                            .cornerRadius(20)
                                            .padding(.trailing, 7)
                                        
                                        VStack(alignment: .leading){
                                            Text(hidingGoodsItem.title)
                                                .font(.system(size: 15))
                                            //                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                .padding(.bottom, 3)
                                            Text("3분전")
                                                .font(.system(size: 13))
                                                .foregroundColor(Color(hex: "828282"))
                                            HStack{
                                                MarketTag(tag: "EXIT")
                                                MarketTag(tag: "앨범")
                                            }// end HStack
                                            HStack(alignment: .bottom){
                                                Text("\(hidingGoodsItem.price)")
                                                    .font(.system(size: 16))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                //                        .padding(.top, 10)
                                                Spacer()
                                                HStack(spacing:2){
                                                    Image(systemName: "suit.heart")
                                                        .resizable()
                                                        .frame(width:15, height: 13)
                                                    Text("10")
                                                        .font(.system(size: 14))
                                                        .padding(.trailing, 5)
                                                    Image(systemName: "message")
                                                        .resizable()
                                                        .frame(width:15, height: 13)
                                                    Text("4")
                                                        .font(.system(size: 14))
                                                        .padding(.trailing, 7)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
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
