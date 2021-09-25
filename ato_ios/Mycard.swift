//
//  mycard.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/08.
//

import SwiftUI

struct Mycard : View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Rectangle().frame(height: 0)    // 이게 있으면 상단에 기본적으로 spacing이 들어감. 임의로 없애 줘야 한다.
            Text("창대리 유툽 프로젝트")
                .font(.system(size: 23))
                .fontWeight(.black)
            Text("10AM - 11AM")
//                .padding(.bottom, 10)
                Spacer().frame(height: 10)
            HStack{
                Image("1")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(           // 덧 씌울거다.
                        Circle()
                            .stroke(lineWidth: 5)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    )
                Image("2")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/) // 원으로 사진을 자른다.
                Image("3")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                Circle().frame(width: 50, height: 50)
//                Circle().frame(width: 50, height: 50)
//                Circle().frame(width: 50, height: 50)
            }
            
        }
        .padding(30)
        .background(Color.yellow)
        .cornerRadius(20)
        
    }
}

struct Mycard_Previews : PreviewProvider {
    static var previews: some View{
        Mycard()
    }
}
