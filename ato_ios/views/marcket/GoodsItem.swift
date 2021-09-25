//
//  GoodsItem.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/15.
//  메인 화면의 판매하는 물품 1개 간단히 보여줌

import Foundation
import SwiftUI

struct GoodsItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            Rectangle().frame(height: 0)
            HStack{
                Rectangle().frame(width: 110, height: 120)
                    .background(Color(hex: "C4C4C4"))
                    .cornerRadius(20)
                    .padding(.trailing, 7)
                
                VStack(alignment: .leading){
                    Text("NCT 앨범")
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
                    Text("10,000원")
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
                        
                    }// end HStack
                    
                    //                    Spacer().frame(height: 70)
                   
                    
                    
                } // end VStack
                //                .background(Color.red)
                //                .border(width: 5, edge: .bottom, color: .yellow)
                //            Spacer()
                
                
            } // end HStack
            .padding([.top, .bottom], 15)
//            .padding(.bottom, 10)
            .padding([.leading, .trailing], 7)
//            Rectangle().frame(width:100, height: 0.5)
                Divider()
        } // end VStack
        //        .border(width: 5, edge: .top, color: .yellow)
        .background(Color.white)
//        .shadow(radius: 5)
//        .shadow( radius: 5)
       
        
        
        
        
    }
}
struct GoodsItem_Previews: PreviewProvider {
    static var previews: some View {
        GoodsItem()
    }
}
