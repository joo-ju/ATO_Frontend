//
//  SearchTabBarButton.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/17.
//

import Foundation
import SwiftUI

struct SearchTabBarButton: View {
    let text: String
    
    @Binding var isSelected: Bool
    var body: some View {
        VStack{
            Rectangle().frame(height:0)
            if text == "아토 마켓" && isSelected {
                Text(text)
                    
                    .fontWeight(isSelected ? .heavy : .regular)
                    .font(.system( size: 20))
                    .frame(maxWidth: .infinity)
                    //            .padding(.bottom,10)
                    .padding()
                    .foregroundColor(Color(hex: "6279B8"))
                    .border(width:4 , edges: [.bottom], color: Color(hex: "6279B8"))
            }
            else if text == "아토 행사" && isSelected {
                Text(text)
                    
                    .fontWeight(isSelected ? .heavy : .regular)
                    .font(.system( size: 20))
                    .frame(maxWidth: .infinity)
                    //            .padding(.bottom,10)
                    .padding()
                    .foregroundColor(Color(hex: "76C598"))
                    //                    .foregroundColor(text == "아토 마켓" && isSelected ? Color(hex: "6279B8") : Color(hex: "c4c4c4"))
                    .border(width:4 , edges: [.bottom], color: Color(hex: "76C598"))
            }
            else {
                Text(text)
                    
                    .fontWeight(isSelected ? .heavy : .regular)
                    .font(.system( size: 20))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor( Color(hex: "c4c4c4"))
                //                    .border(width: isSelected ? 3 : 1, edges: [.bottom], color: .black)
            }
        } // end VStack
    }
}


