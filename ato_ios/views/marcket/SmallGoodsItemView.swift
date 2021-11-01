//
//  SmallGoodsItemView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/31.
//

import SwiftUI


struct SmallGoodsItemView: View {
    
    @State var title = ""
    @State var price = 0
    @State var tags = [""]
    @State var wishCount = 0
    @State var chat = 0
    @State var state = ""
    @State var image = [""]
    @State var URL = "http://localhost:4000/goods/image/"
    @State var imageURL = ""
    var body: some View {
        VStack(alignment: .leading){
            HStack (alignment: .top){
                
                if image.count > 0 {
                    Image(uiImage:imageURL.load())
                        .resizable()
                        .frame(width: 60, height: 65)
                        .cornerRadius(20)
                        .padding(.trailing, 15)
                        .padding(.top, 7)
                        .onAppear(perform: {
                            imageURL = URL + image[image.count - 1]
                        })
                } else {
                Rectangle().frame(width: 110, height: 120)
                    .foregroundColor(Color(hex: "C4C4C4"))
                    .background(Color(hex: "C4C4C4"))
                    .cornerRadius(20)
                    .padding(.trailing, 15)
                    .padding(.top, 7)
                }
                
                VStack(alignment: .leading){
                    Text(title)
                        .font(.system(size: 15))
                        .padding(.top, 10)
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
                }
                Spacer()
            }// end HStack
        }
    }
}
