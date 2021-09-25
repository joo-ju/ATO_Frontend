//
//  MarketSearchTab.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/17.
//

import Foundation
import SwiftUI

struct MarketSearchTab: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Rectangle().frame(height: 0)
                VStack(alignment: .leading){
                Text("최근 검색한 태그")
                    .font(.system(size: 20))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(hex: "6279B8"))
                    .padding([.leading], 20)
                    .padding([.top, .bottom], 10)
                
                HStack{
                    MarketTag(tag:"샤이니")
                    MarketTag(tag:"태민")
                }
                .padding([.leading], 20)
                
                .padding([.bottom], 5)
                HStack{
                    MarketTag(tag:"샤이니")
                    MarketTag(tag:"태민")
                }
                .padding([.leading], 20)
                .padding([.bottom], 10)
//                Divider()
                
                } // end VStack
                .padding([.top, .bottom])
                VStack(alignment: .leading){
                Text("카테고리")
                    .font(.system(size: 20))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(hex: "6279B8"))
                    .padding([.leading], 20)
                    .padding([.top, .bottom], 10)
                
                HStack{
                    Category(text: "스티커")
                    Category(text: "포토카드")
                    Category(text: "엽서")
                    Category(text: "스탬프")
                 
                }
                .padding([.leading], 20)
                
                .padding([.bottom], 5)
                HStack{
                    Category(text: "앨범")
                    Category(text: "엽서")
                    Category(text: "포토카드")
                    Category(text: "포스터")
                }
                .padding([.leading], 20)
                .padding([.bottom], 10)
//                Divider()
                
                } // end VStack
                .padding([.top, .bottom])
                
                
                VStack(alignment: .leading){
                Text("인기 검색어")
                    .font(.system(size: 20))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(hex: "6279B8"))
                    .padding([.leading], 20)
                    .padding([.top, .bottom], 10)
                
                HStack{
                    Keyword(text: "스티커")
                    Keyword(text: "포토카드")
                    Keyword(text: "엽서")
                    Keyword(text: "스탬프")
                 
                }
                .padding([.leading], 20)
                
                .padding([.bottom], 5)
                HStack{
                    Keyword(text: "앨범")
                    Keyword(text: "엽서")
                    Keyword(text: "포토카드")
                    Keyword(text: "포스터")
                }
                .padding([.leading], 20)
                .padding([.bottom], 10)
//                Divider()
                
                } // end VStack
                .padding([.top, .bottom])
            }// end VStack
        }// end ScrollView
    }
}

struct MarketSearchTab_Previews: PreviewProvider {
    static var previews: some View {
        MarketSearchTab()
    }
}


