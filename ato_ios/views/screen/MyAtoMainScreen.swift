//
//  MyAtoMainScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/07.
//  나의 아토 가장 첫번째 화면

import SwiftUI

struct MyAtoMainScreen: View {
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var walletViewModel: WalletViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("나의 ATO")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
            }
            Divider()
            ScrollView{
                
                NavigationLink(destination: EditAccountScreen()){
                    // 계정정보
                    HStack{
                        Image("3")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        Text(userInfo.username)
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
                Divider()
                Spacer()
                HStack(spacing: 20){
                    NavigationLink(destination: SaleHistoryScreen().navigationBarTitleDisplayMode(.inline)){
                        MyAtoMenuButton(name: "판매내역", image: "scroll", isGoods: true)
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    NavigationLink(destination: BuyHistoryScreen().navigationBarTitleDisplayMode(.inline)){
                        MyAtoMenuButton(name: "구매내역", image: "bag", isGoods: true)
                   
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    NavigationLink(destination: WishlistScreen().navigationBarTitleDisplayMode(.inline)){
                        VStack(spacing: 0){
                            
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
                        .padding(10)
                    } // end HStack
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    
                }
                HStack(spacing: 20){
                    if self.userInfo.wallet == "" {         // 지갑 정보가 없을 때
                        Button(action: {
                            walletViewModel.createWallet(parameters: ["userId": self.userInfo.id])
                            print("실행 됨")
                        }, label: {
                            
                            MyAtoMenuButton(name: "지갑생성", image: "rectangle.badge.plus", isGoods: false)
                            
                        })
                    } else {
                        NavigationLink(destination: WalletChargeScreen()){
                            MyAtoMenuButton(name: "지갑 충전", image: "creditcard.fill", isGoods: false)
                        }
                        NavigationLink(destination:Login().navigationBarTitleDisplayMode(.inline)){
                            MyAtoMenuButton(name: "지갑 내역", image: "list.bullet.rectangle", isGoods: false)
                            
                        }
                    }
                    MyAtoMenuButton(name: "리뷰관리", image: "ellipsis.bubble", isGoods: false)
                  
                } // end HStack
                VStack{
                    
                }
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
        } // end VStack
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}

struct MyAtoMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyAtoMainScreen()
    }
}
