//
//  EditGoodsDetailScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/03.
//

import Foundation
import SwiftUI

struct EditGoodsDetailScreen: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    let goodsItem: GoodsModel
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var tags = [""]
    @State var sellerId = "joo"
    @State var buyerId = ""
    @State var categoryId = ""
    @State var score = 0
    @State var count = 0
    @State var wishCount = 0
    @State var chat = 0
    @State var review = false
    @State var text = ""
    @State var idx = 0
    @State var chips : [[ChipData]] = []
    
    // price의 Int 형을 입력받기 위한 formatter
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        
        VStack(spacing: 0){
      
            Rectangle().frame(height:0)
            HStack{
                // 상단바 - 닫기, 저장
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
                Button(action: {
                    //update Goods
                    if title != "" && content != "" {
                        let parameters: [String: Any] = ["id": goodsItem._id, "title": title, "content": content, "price": price, "tags": tags ]
                        print("\nprameters : ", parameters)
                        viewModel.updateGoods(parameters: parameters)
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("저장")
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 15)
                        .foregroundColor(Color(hex: "6279B8"))
                })
                    .accentColor(.black)
            }
            ScrollView{
                VStack{
                    TextField("제목", text: $title)
                        .padding(10)
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
                VStack(spacing: 10){
                    
                    ScrollView{
                        LazyVStack(alignment: .leading,spacing: 10){
                            ForEach(chips.indices,id: \.self){index in
                                
                                HStack{
                                    ForEach(chips[index].indices,id: \.self){chipIndex in
                                        GoodsTag(tag:chips[index][chipIndex].chipText)
                                            .overlay(
                                            
                                                GeometryReader{reader -> Color in
                                                    
                                                    let maxX = reader.frame(in: .global).maxX
                                                    
                                                    if maxX > UIScreen.main.bounds.width - 70 && !chips[index][chipIndex].isExceeded{
                                                        
                                                        DispatchQueue.main.async {
                                                            chips[index][chipIndex].isExceeded = true
                                                            
                                                            let lastItem = chips[index][chipIndex]
                                                            chips.append([lastItem])
                                                            chips[index].remove(at: chipIndex)
                                                        }
                                                    }
                                                    return Color.clear
                                                },
                                                alignment: .trailing
                                            )
                                            .clipShape(Capsule())
                                            .onTapGesture {
                                                tags.remove(at: chips[index][chipIndex].idx )
                                                chips[index].remove(at: chipIndex)
                                              
                                                
                                                if chips[index].isEmpty{
                                                    chips.remove(at: index)
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        .padding([.trailing, .leading], 20)
                    }
                    .frame(height: 60)
                    Divider()
                        .padding([.leading, .trailing], 20)
                    HStack{
                    TextField("태그를 입력해주세요", text: $text)
                        .frame(alignment: .topLeading)
                        .padding(10)
                        .padding([.leading, .trailing], 20)
                    Button(action: {
                        self.chips[chips.count-1].append(ChipData(chipText: text, idx: idx))
                        idx = idx + 1
                        tags.append(text)
                  
                        
                        text = ""
                        
                    }, label: {
                        Text("Add")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(width: 50)
                            .background(Color.purple)
                            .cornerRadius(4)
                    })
                    .disabled(text == "")
                    .opacity(text == "" ? 0.45 : 1)
                    .padding(.trailing)
                    }
                }
            } // end ScrollView
            Spacer()
        }// end Vstack
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear(perform: {
            self.title = goodsItem.title
            self.content = goodsItem.content
            self.price = goodsItem.price
            self.tags = goodsItem.tags
            for text in tags {
                if chips.isEmpty{
                    chips.append([])
                }
            
                chips[chips.count-1].append(ChipData(chipText: text, idx: idx))
                idx = idx + 1
            }
        })
    }
}
