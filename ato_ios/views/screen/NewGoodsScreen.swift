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
    @State var selectedImage: Image? = Image("")
    @State var isUpload: Bool = true           // 사진 저장 버튼을 활성화 하기 위한 변수
        
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
                Divider()
                                          .padding([.leading, .trailing], 20)
                ScrollView{
                    VStack{
                        HStack{
                    Text("사진")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            Spacer()
                        }
                        .padding([.top, .leading, .trailing])
                            .padding(.horizontal, 10)

                        
                      
                        
                       
                        
                        if isUpload == false{
                            // 선택한 사진 조회
                            self.selectedImage?.resizable().scaledToFit().frame( maxHeight: 300, alignment: .center)
                                .padding(.horizontal)
                        // 사진 저장 버튼
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
                            VStack{
                            HStack{
                                Spacer()
                            Text("저장하기")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                                .padding(.vertical, 10)
                            
                            .background(Color(hex: "C3D3FE"))
                            .cornerRadius(10)
                            }
                            .padding(.horizontal)
                            
                        })
                    }
                        else {
                            // 사진 추가 버튼
                            Button(action: {
                                self.showImagePicker.toggle()
                                isUpload = false
                            }, label: {
                                VStack(alignment: .leading){
                                    HStack{
                                Text("+")
                                        .font(.system(size: 30))
                                        .padding(.horizontal, 40)
                                        .padding(.vertical, 30)
                                        .background(Color(hex: "C3D3FE"))
                                        .foregroundColor(Color(hex: "ffffff"))
                                        .cornerRadius(10)
                                        Spacer()
                                }
                                }
                         
                                .padding(.horizontal, 30)
                            })
                        }
                      
                    }
                    .sheet(isPresented: $showImagePicker , content: {
                        ImagePicker(image: $selectedImage)
                    })
                    Divider()
                                              .padding([.leading, .trailing], 20)
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
//                                .lineSpacing(50)
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
