//
//  WishlistScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/07.
//  관심목록 화면

import SwiftUI

struct WishlistScreen: View {
    
    @State var tabIndex = 0
    var body: some View {
        VStack{
            WishListTabBar(tabIndex: $tabIndex)
            if tabIndex == 0 {
                MarketTab()
            }
            else if tabIndex == 1{
                TicketTab()
            }
        }
        
        .navigationTitle("관심목록")
        .navigationBarBackButtonHidden(false)
    }
    
}


struct TicketTab: View {
    
    @State var tabIndex = 0
    var body: some View {
        VStack{
            Spacer()
        }
    }
    
}
struct MarketTab: View {
    
    @ObservedObject var userInfo = UserInfo()
    @State var tabIndex = 0
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var userViewModel: UserViewModel
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
            
            if viewModel.wishedGoodsItems.count != 0 {
                List{
                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                        
                        ForEach(viewModel.wishedGoodsItems.reversed(), id: \._id){ wishedGoodsItem in
                            
                            NavigationLink(destination: GoodsDetailViewScreen(goodsItem: wishedGoodsItem), label: {
                                GoodsItemView(title: wishedGoodsItem.title, price: wishedGoodsItem.price, tags: wishedGoodsItem.tags, wishCount: wishedGoodsItem.wishCount, chat: wishedGoodsItem.chat, state: wishedGoodsItem.state)
                            })
                        }
                        
                    } onUpdate: {
                        viewModel.fetchWishGoodsId(parameters: self.userInfo.id)
                    }
                    
                }
                .listStyle(InsetListStyle())
                .foregroundColor(Color.black)
            } else {
                Spacer()
                VStack{
                    Text("관심있는 Goods가 없습니다.")
                        .foregroundColor(Color(hex:"c4c4c4"))
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            viewModel.fetchWishGoodsId(parameters: self.userInfo.id)
        })
            
        }
    }
    
