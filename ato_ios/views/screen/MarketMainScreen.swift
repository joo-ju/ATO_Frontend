//
//  MainMarket.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/15.
//  중고거래 메인화면

import Foundation
import SwiftUI

struct MarketMain : View {
    
    
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var tags = [""]
    
    var body: some View {
        NavigationView{
            ZStack{
                // 전체 화면 색상 변경
                Color(hex: "C3D3FE").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(spacing: 15){
                    // 검색바
                    MarketMainSearch()
                    
                    // 상품 목록
                    //                    VStack(spacing: 0){
                    
                    List{
                        ForEach(viewModel.goodsItems, id: \._id){ goodsItem in
                            
                            NavigationLink(destination: Login(), label: {
                                //                                        print("goodsItem: ", goodsItem)
                                VStack(alignment: .leading){
                                    HStack{
                                        Rectangle().frame(width: 110, height: 120)
                                            .background(Color(hex: "C4C4C4"))
                                            .cornerRadius(20)
                                            .padding(.trailing, 7)
                                        
                                        VStack(alignment: .leading){
                                            Text(goodsItem.title)
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
                                                Text("\(goodsItem.price)")
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
                                        
                                    }// end HStack
                                    //                                    Text(goodsItem.title)
                                    //                                    Text(goodsItem.content)
                                    //                                        .font(.caption).foregroundColor(.gray)
                                }
                            })
                        }
                    }
                    .listStyle(InsetListStyle())
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    //                                            .navigationBarTitle("Posts")
                    //                                            .navigationBarItems(trailing: plusButton)
                }
                .sheet(isPresented: $isPresentedNewPost, content: {
                    NewGoodsScreen(isPresented: $isPresentedNewPost, title: $title, content: $content, price: $price, tags: $tags)
                })
                .onAppear(perform: {
                    viewModel.fetchAllGoods()
                })
      
                Spacer()
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: NewGoodsScreen(isPresented: $isPresentedNewPost, title: $title, content: $content, price: $price, tags: $tags)){
                            plusButton
                            //                    Text("+")
                            //                        .font(.system(.largeTitle))
                            //                        .frame(width: 66, height: 60)
                            //                        .foregroundColor(Color.white)
                            //                        .padding(.bottom, 7)
                            //                        .background(Color(hex:"6279B8"))
                            //                        .cornerRadius(38.5)
                            //                        .padding()
                            //                        .shadow(color: Color.black.opacity(0.3),
                            //                                radius: 3,
                            //                                x: 3,
                            //                                y: 3)
                        }// end Navigation Link
                        //                .navigationBarHidden(true)
                        //                .navigationBarBackButtonHidden(true)
                        
                    }
                }
            }// end ZStack
        } // end NavigationView
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
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

//struct MarketMain_Previews: PreviewProvider {
//    static var previews: some View {
//        MarketMain()
//    }
//}
