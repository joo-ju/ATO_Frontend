//
//  WriteGoodsScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/23.
//

import Foundation
import SwiftUI

struct WriteGoodsScreen : View {
    @State var price:String = ""
    @State var title:String = ""
    @State var content:String = ""
    @State var tag:String = ""
    @State var text:String = ""
    
    @State var chips : [[ChipData]] = [
        //Sample Data For Testing...
        [ChipData(chipText: "hello"),ChipData(chipText: "world"),ChipData(chipText: "guys")]
        
    ]
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0){
            Rectangle().frame(height:0)
            HStack{
                // 상단 헤더
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("닫기")
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 15)
                        .foregroundColor(Color(hex: "838383"))
                })
                .accentColor(.black)
                Spacer()
                Text("판매 글쓰기")
                    .font(.system(size:23))
                Spacer()
                Text("완료")
                    .fontWeight(.bold)
                    .padding([.leading, .trailing])
                    .padding([.top, .bottom], 15)
                    .foregroundColor(Color(hex: "6279B8"))
                
                
            } // end HStack
            
            
            
            Divider()
                .padding(.bottom, 10)
            
            ScrollView{
                VStack{
                    TextField("제목", text: $title)
                        .padding(10)
                        //                    .padding(.top, 5)
                        .padding([.leading, .trailing], 20)
                    
                    Divider()
                        .padding([.leading, .trailing], 20)
                    NavigationLink(destination: Login()){
                        HStack{
                            Text("카테고리 선택")
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
                    Divider()
                        .padding([.leading, .trailing], 20)
                    TextField("₩ 가격", text: $price)
                        .padding(10)
                        .padding([.leading, .trailing], 20)
                    Divider()
                        .padding([.leading, .trailing], 20)
                    ScrollView{
                        TextField("판매 글의 내용을 작성해주세요.", text: $content)
                            .frame(height: 400, alignment: .topLeading)
                            .padding(10)
                            .padding([.leading, .trailing], 20)
                    } // end ScrollView
                    Divider()
                        .padding([.leading, .trailing], 20)
                    

                }// end VStack
                
                MarcketWriteChips()
            } // end ScrollView
            Spacer()
        }// end Vstack
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    } // end View
} // end WriteGoodsScreen

struct WriteGoodsScreen_Previews: PreviewProvider {
    static var previews: some View {
        WriteGoodsScreen()
    }
}
