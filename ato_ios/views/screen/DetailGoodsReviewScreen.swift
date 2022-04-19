//
//  DetailGoodsReviewScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/31.
//

// 사용 안함

import SwiftUI

struct DetailGoodsReviewScreen: View {
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var reviewViewModel: ReviewViewModel
    @Environment(\.presentationMode) var presentationMode
    let goodsItem: GoodsModel
    @State var score = 0
    
    var body: some View {
        VStack{
            Divider()
            NavigationLink(destination: DetailGoodsScreen(goodsItem: goodsItem)){
            SmallGoodsItemView(title: goodsItem.title, price: goodsItem.price, tags: goodsItem.tags, wishCount: goodsItem.wishCount, chat: goodsItem.chat, state: goodsItem.state, image: goodsItem.image)
                .padding(.horizontal)
            }
            Divider()
            
            ScrollView{
                HStack{
                    
                    ForEach(0..<5){ num in
                        Image(systemName: num < reviewViewModel.oneReviewGoodsItem?.score ?? 0 ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(num < reviewViewModel.oneReviewGoodsItem?.score ?? 0 ? Color(hex: "8EA4D2") : Color.black.opacity(0.13))
                    } .onAppear(perform: {
                        score = reviewViewModel.oneReviewGoodsItem?.score ?? 0
                        print(score)
                    })
                    Spacer()
                }
                .padding()
                VStack(alignment: .leading){
                    ScrollView{
                        Divider()
                            .padding([.leading, .trailing], 20)
                        VStack(alignment: .leading, spacing: 10) {
                            Rectangle().frame(height: 0)
                        Text(reviewViewModel.oneReviewGoodsItem?.content ?? "리뷰를 가져오지 못했습니다.")
                            .padding([.top, .bottom], 10)

                            .lineSpacing(5)
                         
                        }
                        .padding(.horizontal, 20)
                    } // end ScrollView
              
                }// end VStack
            }
        }
        .onAppear(perform: {
            reviewViewModel.fetchOneReviewGoods(userId: self.userInfo.id, goodsId: goodsItem._id)
        })
    }
}

