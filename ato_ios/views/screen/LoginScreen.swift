//
//  Login.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/10.
//

import SwiftUI

struct Login : View {
    
    
    @State var username: String = ""
    @State var password: String = ""
    @State var tag:String? = nil
    
    var body: some View {
        
        
        VStack{
            
            Text("로그인")
                
                .font(.system(size: 40))
                .fontWeight(.bold)
                .padding(.top, 25)
            Text("로그인하고 다양한 혜택을 받아보세요!")
                .padding(5)
                .font(.system(size: 18))
            
            VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
                
                VStack(alignment: .leading, spacing: nil){
                    Text("아이디")
                        .padding(.leading, 45)
                        .padding(.top, 15)
                    //                        .foregroundColor(Color(hex:"828282"))
                    //                        .padding(.top)
                    TextField("6 ~ 20자 영문, 숫자", text: $username)
                        .padding()
                        //                        .textFieldStyle()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "828282"), lineWidth: 1))
                        //                        .padding()
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
                
                
                VStack(alignment: .leading, spacing: nil){
                    Text("비밀번호")
                        .padding(.leading, 45)
                        .padding(.top, 15)
                    SecureField("영문, 숫자, 특수문자 포함 8자리 이상", text: $password)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "828282"), lineWidth: 1))
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
            }
            Spacer()
            NavigationLink(destination: Register()){
                VStack{
                    Rectangle().frame(height: 0)
                    Text("회원가입하기")
                        .fontWeight(.bold)
                }
                .padding(.bottom, 20)
                .padding(.top, 10)
                .background(Color.black)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(30)
            }
//            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
