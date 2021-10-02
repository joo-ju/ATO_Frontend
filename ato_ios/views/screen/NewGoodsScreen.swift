//
//  WriteGoodsScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/23.
//

import Foundation
import SwiftUI

struct NewGoodsScreen : View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var content: String
    @Binding var price:Int
    @Binding var tags: Array<String>
    @State var text:String = ""
    @State var isAlert = false
    //    @State var chips : [[ChipData]] = [
    //        //Sample Data For Testing...
    //        [ChipData(chipText: "hello"),ChipData(chipText: "world"),ChipData(chipText: "guys")]
    //
    //    ]
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                Rectangle().frame(height:0)
                HStack{
                    leading
                    Spacer()
                    Text("판매 글쓰기")
                        .font(.system(size:18))
                    Spacer()
                    trailing
                }
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
                        TextField("₩ 가격", value: $price, formatter: formatter)
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
                    
                    MarcketWriteChips(tags: $tags)
                } // end ScrollView
                Spacer()
            }// end Vstack
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            //        .navigationTitle("판매 글쓰기")
            //        .navigationBarTitleDisplayMode(.inline)
            //        .navigationBarItems(leading: leading, trailing: trailing)
            
        } // end NavigationView
    } // end View
    
    var leading: some View{
        Button(action:{
            isPresented.toggle()
        } , label: {
            Text("닫기")
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 15)
                .foregroundColor(Color(hex: "838383"))
        })
    }
    var trailing: some View{
        Button(action:{
            if title != "" && content != ""{
                let parameters: [String: Any] = ["title": title, "content": content, "price": price, "tags": tags ]
                print("tags : ", tags)
                viewModel.createGoods(parameters: parameters)
                viewModel.fetchAllGoods()
                
                isPresented.toggle()
            } else {
                isAlert.toggle()
            }
            
        } , label: {
            
            Text("완료")
                .fontWeight(.bold)
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 15)
                .foregroundColor(Color(hex: "6279B8"))
        })
    }
} // end WriteGoodsScreen

//struct WriteGoodsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteGoodsScreen()
//    }
//}
