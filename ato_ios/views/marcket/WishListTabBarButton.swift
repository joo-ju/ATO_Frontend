//
//  WishListTabBarButton.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/12.
//

import SwiftUI

struct WishListTabBarButton: View {
    let text: String
    
    @Binding var isSelected: Bool
    var body: some View {
        VStack(spacing: 3){
            Rectangle().frame(height:0)
        if  isSelected && text == "아토마켓"{
                Text(text)
                    .fontWeight(isSelected ? .heavy : .regular)
                    .font(.system( size: 17))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .foregroundColor(Color(hex: "ffffff"))
                    .background(Color(hex: "A9BCE8"))
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .border(width:4 , edges: [.bottom], color: Color(hex: "A9BCE8"))
            }
            else if  isSelected && text == "아토티켓"{
                Text(text)
                    .fontWeight(isSelected ? .heavy : .regular)
                    .font(.system( size: 17))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .foregroundColor(Color(hex: "ffffff"))
                    .background(Color(hex: "76C598"))
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .border(width:4 , edges: [.bottom], color: Color(hex: "76C598"))
            }
            else {
                Text(text)

                    .fontWeight(isSelected ? .heavy : .regular)
                    .font(.system( size: 15))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .foregroundColor( Color(hex: "c4c4c4"))
            }
        } // end VStack
    }
}
