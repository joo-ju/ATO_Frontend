//
//  TopBar.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/17.
//

import Foundation
import SwiftUI


struct TopBar : View {
    
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 20) {
            SearchTabBarButton(text: "아토 마켓", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            SearchTabBarButton(text: "아토 행사", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
        }
        .border(width: 1, edges: [.bottom], color: Color(hex: "c4c4c4"))
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}



