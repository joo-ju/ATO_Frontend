//
//  MainMarket.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/15.
//  중고거래 메인화면

import Foundation
import SwiftUI

struct MarketMain : View {
    var body: some View {
        ZStack{
            // 전체 화면 색상 변경
            Color(hex: "C3D3FE").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 15){
            // 검색바
            MarketMainSearch()
            ScrollView{
                // 상품 목록
                VStack(spacing: 0){
                    GoodsItem()
                    GoodsItem()
                    GoodsItem()
                    GoodsItem()
                    GoodsItem()
                    GoodsItem()
                }// end VStack
            } // end ScrollView
        } // end VStack
        .navigationBarHidden(true)
        Spacer()
            
            VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                NavigationLink(destination: WriteGoodsScreen()){
                                    Text("+")
                                    .font(.system(.largeTitle))
                                    .frame(width: 66, height: 60)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 7)
                                .background(Color(hex:"6279B8"))
                                .cornerRadius(38.5)
                                .padding()
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                }// end Navigation Link
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                                
                            }
                        }
          
        } // end ZStack

                
    }
}
struct MarketMain_Previews: PreviewProvider {
    static var previews: some View {
        MarketMain()
    }
}
