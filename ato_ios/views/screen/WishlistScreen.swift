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
//            WishlistTabbar(tabIndex: $tabIndex)
//            if tabIndex == 0 {
//                MarketSearchTab()
//            }
//            else if tabIndex == 1{
//                SoldTab()
//            }
//            else {
//                MarketSearchTab()
//            }
        }
        
//        .navigationTitle("판매내역")
//        .navigationBarBackButtonHidden(false)
    }
    
}

//
//struct SaleTab: View {
//    
//    @State var tabIndex = 0
//    var body: some View {
//        VStack{
//        }
//    }
//    
//}
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
