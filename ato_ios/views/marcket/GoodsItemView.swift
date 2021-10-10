//
//  GoodsItem.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/15.
//  메인 화면의 판매하는 물품 1개 간단히 보여줌

import Foundation
import SwiftUI

struct GoodsItemView: View {
    
    @State var title = ""
    @State var price = 0
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Rectangle().frame(width: 110, height: 120)
                    .background(Color(hex: "C4C4C4"))
                    .cornerRadius(20)
                    .padding(.trailing, 7)
                    .padding(.top, 7)
                
                VStack(alignment: .leading){
                    Text(title)
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
                        Text("\(price)")
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
        
    }
}
//struct GoodsItem_Previews: PreviewProvider {
//    static var previews: some View {
//        GoodsItem()
//    }
//}
