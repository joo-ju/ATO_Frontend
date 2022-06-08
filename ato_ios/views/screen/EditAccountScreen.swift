//
//  EditAccountScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/12.
//  계정 정보 수정할 것.

import SwiftUI
import Alamofire

struct EditAccountScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @ObservedObject var userInfo = UserInfo()
    @State var passwordChange = false
    var body: some View {
        VStack{
            // 프로필 사진
            Circle().frame(width: 150, height:150)
                .background(Color(hex: "ffffff"))
                .foregroundColor(Color(hex: "cecece"))
                .padding(.bottom, 10)
            
            // 별명
            TextField("", text:$userInfo.username)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color(hex: "828282"), lineWidth: 0.5))
                .padding(.leading, 70)
                .padding(.trailing, 70)
                .padding(.bottom, 5)
                Divider()
            HStack{
                Text("이름")
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                    .padding(15)
//                Text(userInfo.username)
                Text("김주희")
                    .padding(10)
                    .padding(.trailing, 20)
                    .font(.system(size: 13))
//                TextField("", text:$userInfo.username)
//                    .padding(10)
//                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(hex: "828282"), lineWidth: 0.5))
//                    .padding(.trailing, 20)
                Spacer()
            }
            
            HStack{
                Text("휴대폰 번호")
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                    .padding(15)
                Text("김주희")
                    .padding(10)
                    .padding(.trailing, 20)
                    .font(.system(size: 13))
                Spacer()
            }
            HStack{
                Text("현재 비밀번호")
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                    .padding(15)
                SecureField("", text:$userInfo.username)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color(hex: "828282"), lineWidth: 0.5))
                Spacer()
            }
            HStack{
                Text("신규 비밀번호")
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                    .padding(15)
                SecureField("", text:$userInfo.username)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color(hex: "828282"), lineWidth: 0.5))
                Spacer()
            }
            
            HStack{
                Spacer()
                Button(action: {
                             
                           }, label: {
                              Text("변경")
                                   .fontWeight(.bold)
                                   .padding(.horizontal, 30)
                                   .padding(.vertical, 10)
                                   .foregroundColor(Color.white)
                                   .background(passwordChange ? Color(hex: "AFFF10") : Color(hex: "cecece"))
                               
                           })
            }
            .padding(.trailing, 10)
            
            HStack{
                Text("이메일")
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                    .padding(15)
//                Text(userInfo.username)
                Text("rlawn97@gmail.com")
                    .foregroundColor(Color.black)
                    .padding(10)
                    .padding(.trailing, 20)
                    .font(.system(size: 13))
                Spacer()
            }
            HStack{
                Text("주소")
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                    .padding(15)
//                Text(userInfo.username)
                Text("서울특별시 동작구 여의대방로 44길 10")
                    .foregroundColor(Color.black)
                    .padding(10)
                    .padding(.trailing, 20)
                    .font(.system(size: 13))
                Spacer()
            }
            
            
//            Spacer()
        
            
            
        }
        .onAppear(perform: {
            
        })
        .navigationTitle("계정정보")
        .navigationBarBackButtonHidden(false)
    }
}

struct EditAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountScreen()
    }
}
