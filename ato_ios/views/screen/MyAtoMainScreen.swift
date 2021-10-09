//
//  MyAtoMainScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/07.
//  나의 아토 가장 첫번째 화면

import SwiftUI

struct MyAtoMainScreen: View {
  
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("나의 ATO")
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
            }
            Divider()
            ScrollView{
                
                NavigationLink(destination: Login()){
                    // 계정정보
                    HStack{
                        Image("3")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        Text("joo-ju")
                            .font(.system(size: 25))
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .padding(10)
                            .padding(.leading, 20)
                            .foregroundColor(.black)
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                    } // end HStack
                    
                    .padding()
                } // end NavigationLink
//                .navigationBarHidden(true)
//                .navigationBarBackButtonHidden(true)
                Divider()
                Spacer()
                HStack(spacing: 20){
                    NavigationLink(destination: SaleHistoryScreen().navigationBarTitleDisplayMode(.inline)){
                    MyAtoMenuButton(name: "판매내역", image: "scroll", isGoods: true)
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    MyAtoMenuButton(name: "구매내역", image: "bag", isGoods: true)
                    //                    MyAtoMenuButton(name: "", image: "bag", isGoods: true)
                    NavigationLink(destination: WishlistScreen().navigationBarTitleDisplayMode(.inline)){
                        VStack(spacing: 0){
                            //            Rectangle().frame(height: 0)
                            
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width:25, height: 25)
                                .padding(20)
                                .foregroundColor(Color(hex: "BB0092"))
                                .background(Color(hex: "FFE0F8"))
                                .clipShape(Circle())
                            
                            
                            Text("관심목록")
                                .fontWeight(.bold)
                                .padding([.top], 5)
                                .foregroundColor(Color(hex: "000000"))
                            
                            
                        }
                        //        .frame(width: .infinity)
                        .padding(10)
                    } // end HStack
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                   
                }
                    HStack(spacing: 20){
                        MyAtoMenuButton(name: "전시회내역", image: "photo", isGoods: false)
                        MyAtoMenuButton(name: "예매내역", image: "calendar", isGoods: false)
                        MyAtoMenuButton(name: "리뷰관리", image: "ellipsis.bubble", isGoods: false)
                        //                    MyAtoMenuButton(name: "", image: "bag", isGoods: true)
                        
                    } // end HStack
                    Divider()
                    NavigationLink(destination: Login()){
                        HStack{
                            Text("환경설정")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                .padding(10)
                                .padding(.leading, 20)
                                .foregroundColor(.black)
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                            //                            .imageScale(.large)
                                .padding(10)
                            
                                .padding(.trailing, 20)
                        } // end HStack
                    } // end NavigationLink
                } // end ScrollView
                //            .background(Color.green)
            } // end VStack
//        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
//
}

struct MyAtoMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyAtoMainScreen()
    }
}
