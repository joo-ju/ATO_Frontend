//
//  Register.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/10.
//

import SwiftUI

struct Register : View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var name: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    
    
    @State var tag:String? = nil
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView{
            ZStack(alignment: .topLeading) {
                Button(action: {
                               presentationMode.wrappedValue.dismiss()
                           }, label: {
                               Image(systemName: "xmark")
                                   .imageScale(.large)
                                   .padding()
                           })
                           .accentColor(.black)
            
            VStack{
                Text("회원가입")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .padding(.top,20)
                Spacer()
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
                    VStack(alignment: .leading, spacing: nil){
                        Text("비밀번호 확인")
                            .padding(.leading, 45)
                            .padding(.top, 15)
                        SecureField("영문, 숫자, 특수문자 포함 8자리 이상", text: $confirmPassword)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "828282"), lineWidth: 1))
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                    }
                    VStack(alignment: .leading, spacing: nil){
                        Text("이름")
                            .padding(.leading, 45)
                            .padding(.top, 15)
                        TextField("이름", text: $name)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "828282"), lineWidth: 1))
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                    }
                    VStack(alignment: .leading, spacing: nil){
                        Text("이메일")
                            .padding(.leading, 45)
                            .padding(.top, 15)
                        TextField("your@gmail.com", text: $email)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "828282"), lineWidth: 1))
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .keyboardType(.emailAddress)
                    }
                    VStack(alignment: .leading, spacing: nil){
                        Text("휴대폰 번호")
                            .padding(.leading, 45)
                            .padding(.top, 15)
                        TextField("000-0000-0000", text: $phone)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "828282"), lineWidth: 1))
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .keyboardType(.numberPad)
                    }
                    
                 
                    
//                    NavigationLink(destination: Register()){
                        VStack{
                            Rectangle().frame(height: 0)
                            Text("회원가입 하기")
                                .fontWeight(.bold)
                        }
                        .padding(.bottom, 20)
                        .padding(.top, 10)
                        .background(Color.black)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(30)
//                    }
                    
                    Spacer()
                }
                
            }
            }
        }
       
        
    }
}


struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
