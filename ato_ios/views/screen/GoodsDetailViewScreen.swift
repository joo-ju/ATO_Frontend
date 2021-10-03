//
//  GoodsViewScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/02.
//  각각의 상품 판매 글을 상세히 볼 수 있는 Screen

import SwiftUI

struct GoodsDetailViewScreen: View {
    //    @State var tags = [String]()
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    let goodsItem: GoodsModel
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var tags = [""]
    @State var idx = 0
    @State var chips : [[ChipData]] = []
//    let chips = TagsToChips(GoodsDetailViewScreen)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                // 상단바 - 닫기, 수정
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .padding()
            })
                .accentColor(.black)
                Spacer()
//                Button(action: {
//
//                }, label: {
                    NavigationLink(destination: EditGoodsDetailScreen(goodsItem: goodsItem), label: {
                        Text("수정")
                               .fontWeight(.bold)
                               .padding([.leading, .trailing])
                               .padding([.top, .bottom], 15)
                               .foregroundColor(Color(hex: "6279B8"))
                    })
//                })
                    .accentColor(.black)
            }
            ScrollView{
                VStack(alignment: .leading, spacing: 10) {
                    Rectangle().frame(height:0)
                    Text(title)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding([.top, .bottom], 10)
                    
                    Divider()
                    
                    Text(content)
                        .padding([.top, .bottom], 10)
                    
                        .lineSpacing(5)
                    
                    Divider()
         
                    LazyVStack(alignment: .leading,spacing: 10){
                        
                        // Since Were Using Indices So WE Need To Specify Id....
                        ForEach(chips.indices,id: \.self){index in
                            
                            HStack{
                                
                                // some times it asks us to specify hashable in Data Model...
                                ForEach(chips[index].indices,id: \.self){chipIndex in
                                    MarketTag(tag:chips[index][chipIndex].chipText)
                                    //                                Text(chips[index][chipIndex].chipText)
                                    //                                    .font(.system(size: 15))
                                    //                                    .fontWeight(.semibold)
                                    //                                    .padding(.vertical,10)
                                    //                                    .padding(.horizontal, 10)
                                    //                                    .background(Capsule().stroke(Color(hex: "C3D3FE"),lineWidth: 1))
                                    //                                    .background(Color(hex: "C3D3FE"))
                                    //                                    .foregroundColor(Color.white)
                                    //                                    .lineLimit(1)
                                    // Main Logic......
                                        .overlay(
                                            
                                            GeometryReader{reader -> Color in
                                                
                                                // By Using MaxX Parameter We Can Use Logic And Determine if its exceeds or not....
                                                
                                                let maxX = reader.frame(in: .global).maxX
                                                
                                                // Both Paddings  = 30+ 30 = 60
                                                // Plus 10 For Extra....
                                                
                                                // Doing Action Only If The Item Exceeds...
                                                
                                                if maxX > UIScreen.main.bounds.width - 70 && !chips[index][chipIndex].isExceeded{
                                                    
                                                    // It is updating to each user interaction....
                                                    
                                                    DispatchQueue.main.async {
                                                        
                                                        // Toggling That...
                                                        chips[index][chipIndex].isExceeded = true
                                                        
                                                        // Getting Last Item...
                                                        let lastItem = chips[index][chipIndex]
                                                        // removing Item From Current Row...
                                                        // inserting it as new item...
                                                        chips.append([lastItem])
                                                        chips[index].remove(at: chipIndex)
                                                        
                                                    }
                                                }
                                                
                                                return Color.clear
                                            },
                                            alignment: .trailing
                                        )
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }

                    Spacer()
                    
                } // end of VStack
                
            } // end of ScrollView
            
            .padding([.leading, .trailing], 20)
            
            HStack{
                Image(systemName: "heart")
                    .resizable()
                    .frame(width:20, height: 15)
                    .foregroundColor(Color(hex: "c4c4c4"))
                Divider()
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                //                Text("20,000원")
                Text("\(price)")
                    .fontWeight(.bold)
                Spacer()
                Button(action:{ }, label: {
                    HStack{
                        //                            Rectangle().frame(height: 0)
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .frame(width:20, height: 15)
                            .foregroundColor(Color(hex: "ffffff"))
                            .padding(.trailing, 10)
                        Text("대화하기")
                            .fontWeight(.bold)
                    }
                    .frame(width: 120)
                    .padding(10)
                    .background(Color(hex: "A9BCE8"))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                })
            } // end of HStack
            .frame(height: 50, alignment: .center)
            .padding([.leading, .trailing], 15)
            .padding(.leading, 5)
            //                .background(Color.green)
            
        } // end of VStack
        //        .navigationBarTitleDisplayMode(.inline)
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
                print("Chips : ", chips)
                print("chips.count : ", chips.count)
                print("text: ", text)
                print("tags: ", tags)
    //            chips[chips.count - 1].append(ChipData(chipText: text, idx: idx))
                chips[chips.count-1].append(ChipData(chipText: text, idx: idx))
                idx = idx + 1
            }
            
        })
        
        
        //            } // end of ZStack
        
    }
    
//    func TagsToChips() {
//
//        for text in tags {
//            if chips.isEmpty{
//                chips.append([])
//            }
//            print("Chips : ", chips)
//            print("chips.count : ", chips.count)
//            print("text: ", text)
//            print("tags: ", tags)
////            chips[chips.count - 1].append(ChipData(chipText: text, idx: idx))
//            chips[chips.count].append(ChipData(chipText: text, idx: idx))
//            idx = idx + 1
//        }
//        print("Chips : ", chips)
//    }
    
}
//
//struct GoodsViewScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        GoodsDetailViewScreen()
//    }
//}
