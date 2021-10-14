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
//            else {
//                MarketSearchTab()
//            }
        }
        
        .navigationTitle("관심목록")
        .navigationBarBackButtonHidden(false)
    }
    
}


struct MarketTab: View {
    
    @State var tabIndex = 0
    var body: some View {
        VStack{
            
        }
    }
    
}
struct TicketTab: View {
    
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
//    var wish = UserHistoryModel.self
    var body: some View {
        VStack{
            
//            if !userViewModel.userHistoryItem.isEmpty  {
//                List{
//                    KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                        
//                        ForEach(userViewModel.userHistoryItem, id: \._id){ wishGood in
////                            viewModel.fetchOneGoodsId(parameters: wishGood)
//                            VStack {
//                                Text(wishGood.userId)
//                            }.onAppear(perform: {
////                                print("wishGoods[0]: ", wishGoods[0])
//                               
//                                
//                               
//                            })
////                            NavigationLink(destination: GoodsDetailViewScreen(goodsItem: wishGood), label: {
////                                GoodsItemView(title: saleGoodsItem.title, price: saleGoodsItem.price)
////                            })
//                        }
                        
//                    } onUpdate: {
////                        viewModel.fetchGoodsSaleSellerId(parameters: sellerId)
//                    }
//
//                }
//                .listStyle(InsetListStyle())
//                .foregroundColor(Color.black)
//            } else {
//                Spacer()
//                VStack{
//                    Text("판매중인 게시물이 없습니다.")
//                        .foregroundColor(Color(hex:"c4c4c4"))
//                }
//                Spacer()
//            }
        }
        .onAppear(perform: {
            userViewModel.fetchUserHistory(parameters: self.userInfo.id)
//            print(userViewModel.userHistoryItem)
            viewModel.fetchOneGoodsId(parameters: "61610e9b8cf5f894d6597eee")
        })
            
        }
    }
    

//struct SoldTab: View {
//    
//    @State var tabIndex = 0
//    @EnvironmentObject var viewModel: ViewModel
//    @State var isPresentedNewPost = false
//    @State var title = ""
//    @State var content = ""
//    @State var price = 0
//    @State var tags = [""]
//    var body: some View {
//        List{
//            KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
//                ForEach(viewModel.goodsItems.reversed(), id: \._id){ goodsItem in
//                    
//                    NavigationLink(destination: GoodsDetailViewScreen(goodsItem: goodsItem), label: {
//                        //                                        print("goodsItem: ", goodsItem)
//                        
//                        VStack(alignment: .leading){
//                            HStack{
//                                Rectangle().frame(width: 110, height: 120)
//                                    .background(Color(hex: "C4C4C4"))
//                                    .cornerRadius(20)
//                                    .padding(.trailing, 7)
//                                
//                                VStack(alignment: .leading){
//                                    Text(goodsItem.title)
//                                        .font(.system(size: 15))
//                                    //                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                                        .padding(.bottom, 3)
//                                    Text("3분전")
//                                        .font(.system(size: 13))
//                                        .foregroundColor(Color(hex: "828282"))
//                                    HStack{
//                                        MarketTag(tag: "EXIT")
//                                        MarketTag(tag: "앨범")
//                                    }// end HStack
//                                    HStack(alignment: .bottom){
//                                        Text("\(goodsItem.price)")
//                                            .font(.system(size: 16))
//                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                                        //                        .padding(.top, 10)
//                                        Spacer()
//                                        HStack(spacing:2){
//                                            Image(systemName: "suit.heart")
//                                                .resizable()
//                                                .frame(width:15, height: 13)
//                                            Text("10")
//                                                .font(.system(size: 14))
//                                                .padding(.trailing, 5)
//                                            Image(systemName: "message")
//                                                .resizable()
//                                                .frame(width:15, height: 13)
//                                            Text("4")
//                                                .font(.system(size: 14))
//                                                .padding(.trailing, 7)
//                                        }
//                                    }
//                                }
//                                
//                            }// end HStack
//                            //                                    Text(goodsItem.title)
//                            //                                    Text(goodsItem.content)
//                            //                                        .font(.caption).foregroundColor(.gray)
//                        }
//                      
//                    })
//                }
//            } onUpdate: {
//                viewModel.fetchAllGoods()
//            }
//        }
//
//        .listStyle(InsetListStyle())
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//        .foregroundColor(Color.black)
////        .background(Color.green)
//    }
//    
//}
//struct HidingTab: View {
//    
//    @State var tabIndex = 0
//    var body: some View {
//        VStack{
//        }
//    }
//    
//}
struct WishlistScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishlistScreen()
    }
}
