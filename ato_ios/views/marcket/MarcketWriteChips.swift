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
    
    @State var chips : [[ChipData]] = []
    
    var body: some View{
        
        VStack(spacing: 10){
            
            ScrollView{
                // Chips View...
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
                                    .onTapGesture {
                                        // Removing Data...
                                        chips[index].remove(at: chipIndex)
                                        // If the Inside Array is empty removing that also...
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
            
             // Border With Fixed Size...
//                 .frame(height: 150)
//            TextField("태그를 입력해주세요",text: $text)
//
//            // Border With Fixed Size...
//                .frame(height: 150)
//                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.4),lineWidth: 4.5))
            
            // Add Button...
            
            Button(action: {

                // Adding Empty Array if there is Nothing....
                if chips.isEmpty{
                    chips.append([])
                }
                
                // Adding Chip To Last Array....
                chips[chips.count - 1].append(ChipData(chipText: text))
                // Clearing Old Text In Editor
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
            // Disabling Button When Text is Empty...
            .disabled(text == "")
            .opacity(text == "" ? 0.45 : 1)
            .padding(.trailing)
            }
        }
       
    }
}

// Chip Data Model....

struct ChipData: Identifiable {
    var id = UUID().uuidString
    var chipText : String
    // To Stop Auto Update...
    var isExceeded = false
}
struct MarcketWriteChips_Previews: PreviewProvider {
    static var previews: some View {
        MarcketWriteChips()
    }
}

// 유투브 보고 따라한 것 overlay
