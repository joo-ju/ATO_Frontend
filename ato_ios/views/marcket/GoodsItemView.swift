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
    @State var tags = [""]
    @State var wishCount = 0
    @State var chat = 0
    @State var state = ""
    
    var body: some View {
        VStack(alignment: .leading){
            HStack (alignment: .top){
                Rectangle().frame(width: 110, height: 120)
                    .background(Color(hex: "C4C4C4"))
                    .cornerRadius(20)
                    .padding(.trailing, 7)
                    .padding(.top, 7)
                
                VStack(alignment: .leading){
                    Text(title)
                        .font(.system(size: 15))
                        .padding(.top, 10)
                    //                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 3)
                    Text("3분전")
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "828282"))
                    HStack{
                        if tags.count > 0{
                        ForEach(tags,id: \.self){index in
                        MarketTag(tag: index)
                        
                        }
                        }
                         
                    }// end HStack
                    .padding(.bottom, 3)
                    HStack(alignment: .center, spacing: 7){
                        if state == "판매완료" {
                            Text("거래완료")
                                .font(.system(size: 13))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(5)
                                .background(Color(hex: "253153"))
                                .foregroundColor(Color.white)
                                .cornerRadius(5)
                        }
                        Text("\(price)원")
                            .font(.system(size: 16))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        //                        .padding(.top, 10)
                    }
                    Spacer()
                    
                             HStack(spacing:2){
                                 Spacer()
                           
                                     Image(systemName: "suit.heart")
                                         .resizable()
                                         .frame(width:15, height: 13)
                                     Text("\(wishCount)")
                                         .font(.system(size: 14))
                                         .padding(.trailing, 5)
                                     Image(systemName: "message")
                                         .resizable()
                                         .frame(width:15, height: 13)
                                     Text("\(chat)")
                                         .font(.system(size: 14))
                                         .padding(.trailing, 7)
                                 }
                   
                }
                
            }// end HStack
//            .frame(ma)
            //                                    Text(goodsItem.title)
            //                                    Text(goodsItem.content)
            //                                        .font(.caption).foregroundColor(.gray)
//            .background(Color.yellow)
   
//            Divider()
           
        }
        
    }
}
//struct GoodsItem_Previews: PreviewProvider {
//    static var previews: some View {
//        GoodsItem()
//    }
//}
