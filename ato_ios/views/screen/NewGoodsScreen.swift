//
//  WriteGoodsScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/23.
//

import Foundation
import SwiftUI

struct NewGoodsScreen : View {
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var content: String
    @Binding var price:Int
    @Binding var tags: Array<String>
    @Binding var sellerId: String
    @Binding var buyerId: String
    @Binding var categoryId: String
    @Binding var count: Int
    @Binding var score: Int
    @Binding var wishCount: Int
    @Binding var chat: Int
    @Binding var review: Bool
    
    @State var text:String = ""
    @State var isAlert = false
    @State private var cost = 0
    @State var textViewHeight:CGFloat = 50.0
    
//    @State var msg = ""
    
    // Auto Updating TextBox Height...
    @State var containerHeight: CGFloat = 400
    
    // price의 Int 형을 입력받기 위한 formatter
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    @State private var sscore = 0

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
//                            .padding([.leading, .trailing], 20)
//                        NavigationLink(destination: Login()){
//                            HStack{
//                                Text("카테고리 선택")
//                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
//                                    .padding(10)
//                                    .padding(.leading, 20)
//                                    .foregroundColor(.black)
//
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                //                            .imageScale(.large)
//                                    .padding(10)
//
//                                    .padding(.trailing, 20)
//                            } // end HStack
//                        } // end NavigationLink
//                        Divider()
                            .padding([.leading, .trailing], 20)
                        
                             
                        TextField("₩ 가격", value: $price, formatter: formatter)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(10)
                            .padding([.leading, .trailing], 20)
                        Divider()
                            .padding([.leading, .trailing], 20)
                        
                        VStack{
                            
                            AutoSizingTF(hint: "판매 글의 내용을 작성해주세요.", text: $content,containerHeight: $containerHeight, onEnd: {
                                
                                // Do when keyboard closed...
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            })
                                .padding(.horizontal)
                                // Your Max Height Here....
//                                .frame(height: containerHeight <= 400 ? containerHeight : 400)
                                .frame(height: 400)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding()
                        }
//                        ResizeableTextView(text: $content, height: $textViewHeight, placeholderText: "판매 글의 내용을 작성해주세요.").frame(height: textViewHeight < 70 ? self.textViewHeight : 70).cornerRadius(50)
//                        ScrollView{
//
//                            TextField("판매 글의 내용을 작성해주세요.", text: $content)
//                                .frame(height: 400, alignment: .topLeading)
//                                .padding(10)
//                                .padding([.leading, .trailing], 20)
//                        } // end ScrollView
                        Divider()
                            .padding([.leading, .trailing], 20)
                        
                        
                    }// end VStack
                    
                    MarcketWriteChips(tags: $tags)
                } // end ScrollView
                Spacer()
            }// end Vstack
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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
                tags.removeFirst()
                let parameters: [String: Any] = ["title": title, "content": content, "price": price, "tags": tags, "sellerId":self.userInfo.id, "buyerId": "", "score": score, "count": count, "categoryId": categoryId, "wishCount":wishCount, "chat":chat, "review":review]
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
