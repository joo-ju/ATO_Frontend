////
////  Chips.swift
////  ato_ios
////
////  Created by 김주희 on 2021/09/24.
////
//
//import Foundation
//import SwiftUI
//struct Chips: View {
//    let systemImage: String  //pass system image
//    let titleKey: LocalizedStringKey //text or localisation value
//    @State var isSelected: Bool
//    var body: some View {
//        HStack {
//            Image.init(systemName: systemImage).font(.title3)
//            Text(titleKey).font(.title3).lineLimit(1)
//        }.padding(.all, 10)
//        .foregroundColor(isSelected ? .white : .blue)
//        .background(isSelected ? Color.blue : Color.white) //different UI for selected and not selected view
//        .cornerRadius(40)  //rounded Corner
//        .overlay(
//                RoundedRectangle(cornerRadius: 40)
//                    .stroke(Color.blue, lineWidth: 1.5)
//
//        ).onTapGesture {
//            isSelected.toggle() // toggle select - not selected
//        }
//    }
//}
