//
//  WalletChargeScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/11/01.
//

import SwiftUI

struct WalletChargeScreen: View {
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var walletViewModel: WalletViewModel
    @State var price5 = 5000
    @State var price10 = 10000
    @State var price15 = 15000
    @State var price20 = 20000
    @State var price = 0
    @State var isClick5 = false
    @State var isClick10 = false
    @State var isClick15 = false
    @State var isClick20 = false
    @State var balance = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
     
            HStack{
                Text("충전 금액")
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                    .padding()
                    .padding(.leading, 10)
                Spacer()
            }
            HStack (spacing: 30){
                Button(action: {
                    if isClick5 == false {
                        isClick5 = true
                        price = price + 5000
                    } else {
                        isClick5 = false
                        price = price - 5000
                    }
                    
                }, label: {
                    if isClick5 {
                        HStack(spacing: 0){
                            Text("5,000원")
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }
                        .frame(minWidth: 120, maxWidth: 120)
                        
                        .foregroundColor(Color(hex: "ffffff"))
                        .background(Color(hex: "FF7700"))
                        .cornerRadius(50)
                        
                        
                    } else if !isClick5 {
                        HStack(spacing: 0){
                            Text("5,000원")
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }
                        .frame(minWidth: 120, maxWidth: 120)
                        .foregroundColor(Color(hex: "FF7700"))
                        .background(Color(hex: "FFDDC0"))
                        .cornerRadius(50)
                    }
                    
                    
                })
                Button(action: {
                    if isClick10 == false {
                        isClick10 = true
                        price = price + 10000
                    } else {
                        isClick10 = false
                        price = price - 10000
                    }
                    
                }, label: {
                    if isClick10{
                        HStack(spacing: 0){
                            Text("10,000원")
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }
                        .frame(minWidth: 120, maxWidth: 120)
                        .foregroundColor(Color(hex: "ffffff"))
                        .background(Color(hex: "FF7700"))
                        .cornerRadius(50)
                    } else if !isClick10 {
                        HStack(spacing: 0){
                            Text("10,000원")
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }
                        .frame(minWidth: 120, maxWidth: 120)
                        .foregroundColor(Color(hex: "FF7700"))
                        .background(Color(hex: "FFDDC0"))
                        .cornerRadius(50)
                    }
                    
                    
                })
                
            }
            
            
            HStack (spacing: 30){
                Button(action: {
                    if isClick15 == false {
                        isClick15 = true
                        price = price + 15000
                    } else {
                        isClick15 = false
                        price = price - 15000
                    }
                    
                }, label: {
                    if isClick15 {
                        HStack(spacing: 0){
                            Text("15,000원")
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }
                        .frame(minWidth: 120, maxWidth: 120)
                        
                        .foregroundColor(Color(hex: "ffffff"))
                        .background(Color(hex: "FF7700"))
                        .cornerRadius(50)
                        
                        
                    } else if !isClick15 {
                        HStack(spacing: 0){
                            Text("15,000원")
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }
                        .frame(minWidth: 120, maxWidth: 120)
                        .foregroundColor(Color(hex: "FF7700"))
                        .background(Color(hex: "FFDDC0"))
                        .cornerRadius(50)
                    }
                    
                    
                })
                Button(action: {
                    if isClick20 == false {
                        isClick20 = true
                        price = price + 20000
                    } else {
                        isClick20 = false
                        price = price - 20000
                    }
                    
                }, label: {
                    if isClick20{
                        HStack(spacing: 0){
                            Text("20,000원")
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }
                        .frame(minWidth: 120, maxWidth: 120)
                        .foregroundColor(Color(hex: "ffffff"))
                        .background(Color(hex: "FF7700"))
                        .cornerRadius(50)
                    } else if !isClick20 {
                        HStack(spacing: 0){
                            Text("20,000원")
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }
                        .frame(minWidth: 120, maxWidth: 120)
                        .foregroundColor(Color(hex: "FF7700"))
                        .background(Color(hex: "FFDDC0"))
                        .cornerRadius(50)
                    }
                })
            }
            .padding(.top, 15)
            
            Spacer()
            HStack{
                Text("현재 잔액  \(balance)원")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            .onAppear(perform: {
                walletViewModel.fetchOneWallet()
                balance = walletViewModel.walletItem?.balance ?? 0
            })
            
            Button(action: {
                if price != 0 {
                    let parameters: [String: Any] = ["userId": self.userInfo.id, "cost": price]
                    walletViewModel.updateWallet(parameters: parameters)
                    
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                HStack{
                    Spacer()
                    
                    Text("\(price)원 충전하기")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                .background(Color(hex: "253153"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding([.bottom, .leading, .trailing])
                .padding(.leading, 5)
            })
                .navigationTitle("지갑 충전하기")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
