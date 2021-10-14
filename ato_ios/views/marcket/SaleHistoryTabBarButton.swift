//
//  WishlistTabBarButton.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/07.
//

import SwiftUI

struct SaleHistoryTabBarButton: View {
    let text: String
    
    @Binding var isSelected: Bool
    var body: some View {
        VStack(spacing: 3){
            Rectangle().frame(height:0)
            if  isSelected {
                Text(text)
                    .fontWeight(isSelected ? .heavy : .regular)
                    .font(.system( size: 17))
                    .frame(maxWidth: .infinity)
                    //            .padding(.bottom,10)
                    .padding(.vertical)
                    .foregroundColor(Color(hex: "ffffff"))
                    .background(Color(hex: "A9BCE8"))
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .border(width:4 , edges: [.bottom], color: Color(hex: "A9BCE8"))
            }
                
//            else if text == "아토 행사" && isSelected {
//                Text(text)
//
//                    .fontWeight(isSelected ? .heavy : .regular)
//                    .font(.system( size: 20))
//                    .frame(maxWidth: .infinity)
//                    //            .padding(.bottom,10)
//                    .padding()
//                    .foregroundColor(Color(hex: "76C598"))
//                    //                    .foregroundColor(text == "아토 마켓" && isSelected ? Color(hex: "6279B8") : Color(hex: "c4c4c4"))
//                    .border(width:4 , edges: [.bottom], color: Color(hex: "76C598"))
//            }
            else {
                Text(text)
                    
                    .fontWeight(isSelected ? .heavy : .regular)
                    .font(.system( size: 15))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .foregroundColor( Color(hex: "c4c4c4"))
//                    .background(Color.green)
//                    .backgroundColor(Color.green)                //                    .border(width: isSelected ? 3 : 1, edges: [.bottom], color: .black)
            }
        } // end VStack
//        .padding(.leading, 5)
    }
}

//struct WishlistTabBarButton_Previews: PreviewProvider {
//    static var previews: some View {
//        WishlistTabBarButton(text: "아토 마켓")
//    }
//}
