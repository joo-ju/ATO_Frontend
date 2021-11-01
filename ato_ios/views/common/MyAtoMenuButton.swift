//
//  MyAtoMenuButton.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/07.
//

import SwiftUI

struct MyAtoMenuButton: View {
    @State var name = ""
    @State var image = ""
    @State var isGoods = false
    var body: some View {
        VStack(spacing: 0){
//            Rectangle().frame(height: 0)
            if name == "리뷰관리" || name == "지갑생성" || name == "지갑" {
                
                Image(systemName: image)
                    .resizable()
                    .frame(width:25, height: 22)
                    .padding(20)
                    .foregroundColor(Color(hex: "7B7B7B"))
                    .background(Color(hex: "E5E5E5"))
                        .clipShape(Circle())
                
                
            Text(name)
                    .fontWeight(.bold)
                    .padding([.top], 5)
                    .foregroundColor(Color(hex: "000000"))
            }
            else {
            Image(systemName: image)
                .resizable()
                .frame(width:25, height: 25)
                .padding(20)
                .foregroundColor(isGoods ? Color(hex: "6279B8") : Color(hex: "496F5D"))
                .background(isGoods ? Color(hex: "E1E9FF") : Color(hex: "D5F0E1"))
                    .clipShape(Circle())
            
            
        Text(name)
                .fontWeight(.bold)
                .padding([.top], 5)
                .foregroundColor(Color(hex: "000000"))
            }
            
        }
//        .frame(width: .infinity)
        .padding(10)
//        .background(Color(hex: "E1E9FF"))
//        .cornerRadius(10)
   
    }
}

struct MyAtoMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MyAtoMenuButton(name: "판매내역", image: "scroll", isGoods: true)
    }
}
