//
//  WishListTabBar.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/12.
//

import SwiftUI


struct WishListTabBar : View {
    
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 0) {
            WishListTabBarButton(text: "아토마켓", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            WishListTabBarButton(text: "아토티켓", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
        }
        .border(width: 1, edges: [.bottom], color: Color(hex: "c4c4c4"))
        .padding(.horizontal)
   
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}


