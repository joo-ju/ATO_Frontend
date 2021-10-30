//
//  WriteGoodsScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/23.
//

import Foundation
import SwiftUI
import Alamofire

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
    @State var goodsId: String = ""
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
    
    @State var showImagePicker: Bool = false
    //    @Binding var selectedImage: Image
    @State var selectedImage: Image? = Image("")
    
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
                // select image
                VStack{
                    // create button to select image
                    Button(action: {
                        self.showImagePicker.toggle()
                    }, label: {
                        Text("Select image")
                    })
                    
                    //show image
                    self.selectedImage?.resizable().scaledToFit()
                    
                    // show button to upload image
                    Button(action: {

                        let uiImge: UIImage = self.selectedImage.asUIImage()
                        let imageData = uiImge.jpegData(compressionQuality: 0.1)!
                        
                        let url = "http://localhost:4000/goods/image"
                        AF.upload(multipartFormData: { multipartFormData in
                            multipartFormData.append(imageData, withName: "image", fileName: "a.jpg", mimeType: "image/jpg")
                            print(multipartFormData)
                        }, to: url)
                            .responseData { response in
                               guard let data = response.data else { return }
                               let result = try? JSONDecoder().decode(GoodsModel.self, from: data)
                                goodsId = result?._id ?? ""
                        
                            }
                        
                    }, label: {
                        Text("Upload Image")
                    })
                }
                    .sheet(isPresented: $showImagePicker , content: {
                        ImagePicker(image: $selectedImage)
                    })
                Divider()
                                          .padding([.leading, .trailing], 20)
                ScrollView{
                    VStack{
                        TextField("제목", text: $title)
                            .padding(10)
                        //                    .padding(.top, 5)
                            .padding([.leading, .trailing], 20)
                        
                        Divider()
                            .padding([.leading, .trailing], 20)
                        
                             
                        TextField("₩ 가격", value: $price, formatter: formatter)
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
            title = ""
            price = 0
            tags = [""]
            content = ""
            selectedImage = Image("")
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
                print("tags : ", tags)
                if selectedImage == Image("") {
                let parameters: [String: Any] = ["title": title, "content": content, "price": price, "tags": tags, "sellerId":self.userInfo.id, "buyerId": "", "score": score, "count": count, "categoryId": categoryId, "wishCount":wishCount, "chat":chat, "review":review]
                    viewModel.createGoods(parameters: parameters)
                } else {
                    let parameters: [String: Any] = ["id": goodsId, "title": title, "content": content, "price": price, "tags": tags, "sellerId":self.userInfo.id]
                    viewModel.updateGoods(parameters: parameters)
                    print("updateGoods done")
                }
         
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
}
