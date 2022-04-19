//
//  test.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/23.
//

import Foundation

import SwiftUI

struct MarcketWriteChips: View {
    
    @State var text = ""
    
    @Binding var tags: Array<String>
    @State var chips : [[ChipData]] = []
    @State var idx = 0
    var body: some View{
        
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
                if chips.isEmpty{
                    chips.append([])
                }
                chips[chips.count - 1].append(ChipData(chipText: text, idx: idx))
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
       
    }
}
struct ChipData: Identifiable {
    var id = UUID().uuidString
    var chipText : String
    var isExceeded = false
    var idx : Int
}

