//
//  WishlistTopbar.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/07.
//
import Foundation
import SwiftUI


struct SaleHistoryTabbar : View {
    
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 0) {
            SaleHistoryTabBarButton(text: "판매중", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            SaleHistoryTabBarButton(text: "판매완료", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            SaleHistoryTabBarButton(text: "숨김", isSelected: .constant(tabIndex == 2))
                .onTapGesture { onButtonTapped(index: 2) }
        }
        .border(width: 1, edges: [.bottom], color: Color(hex: "c4c4c4"))
        .padding(.horizontal)
   
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}


