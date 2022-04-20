//
//  GoodsItem.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/15.
//  메인 화면의 판매하는 물품 1개 간단히 보여줌

import Foundation
import SwiftUI

struct Goods: View {
    
    @State var title = ""
    @State var price = 0
    @State var tags = [""]
    @State var wishCount = 0
    @State var chat = 0
    @State var updateTime = ""
    @State var state = ""
    @State var image = [""]
    @State var URL = "http://localhost:4000/goods/image/"
    @State var imageURL = ""
    @State var dateString = ""
    var body: some View {
        VStack(alignment: .leading){
            HStack (alignment: .top){
                // GoodsThumbnail
                if image.count > 0 {
                    VStack{
                    Image(uiImage:imageURL.load())
                        .resizable()
                        .onAppear(perform: {
                            imageURL = URL + image[image.count - 1]
                        })
                        .frame(width: 110, height: 120)
                        .cornerRadius(20)
                        .padding(.trailing, 15)
                        .padding(.top, 7)
                        
                   
                    }
                  } else {
                Rectangle().frame(width: 110, height: 120)
                    .foregroundColor(Color(hex: "C4C4C4"))
                    .background(Color(hex: "C4C4C4"))
                    .padding(.trailing, 15)
                    .padding(.top, 7)
                    .cornerRadius(20)
                }
                // GoodsItemContent
                VStack(alignment: .leading){
                    Text(title)
                        .font(.system(size: 15))
                        .padding(.top, 10)
                        .padding(.bottom, 3)
                 
                    Text("\(dateString)")
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "828282"))
                        .onAppear{
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "ko")
                            let _today = Date.now.toString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                            
                            let lastTime = dateFormatter.date(from:updateTime)!
                            let currentTime = dateFormatter.date(from:_today ?? "")!

                            var diff = Int(currentTime.timeIntervalSince(lastTime))
                        
                            
                            if diff >= 86400 {
                                let day = diff / 86400
                                dateString = "\(day)일전"
                                print("\(day)일 전")
                            }
                            else if diff >= 3600 {
                                let hour = diff / 3600
                                dateString = "\(hour)시간 전"
                            }
                            else if diff >= 60 {
                                let minute = diff / 60
                                dateString = "\(minute)분 전"
                            }
                        }
                    
                    HStack{
                        if tags.count > 0{
                            if tags.count > 3 {
                                ForEach(0..<3){idx in
                                    GoodsTag(tag: tags[idx])
                                }
                            } else {
                                ForEach(0..<tags.count){idx in
                                    GoodsTag(tag: tags[idx])
                                }
                                
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
                    }
                    Spacer()
                    
                    HStack(spacing:2){
                        Spacer()
                        
                        // GoodsItemHeart
                        Image(systemName: "suit.heart")
                            .resizable()
                            .frame(width:15, height: 13)
                        Text("\(wishCount)")
                            .font(.system(size: 14))
                            .padding(.trailing, 5)
                        
                        // GoodsItemChat
                        Image(systemName: "message")
                            .resizable()
                            .frame(width:15, height: 13)
                        Text("\(chat)")
                            .font(.system(size: 14))
                            .padding(.trailing, 7)
                    }
                }
            }// end HStack
        }
    }
}
