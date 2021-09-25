////
////  chipsContainer.swift
////  ato_ios
////
////  Created by 김주희 on 2021/09/24.
////
//
//import Foundation
//import SwiftUI
//struct ChipsContent: View {
//    @ObservedObject var viewModel = ChipsViewModel()
//    var body: some View {
//        var width = CGFloat.zero
//        var height = CGFloat.zero
//        return GeometryReader { geo in
//                ZStack(alignment: .topLeading, content: {
//                ForEach(viewModel.dataObject) { chipsData in //loop to render all chips
//                    Chips(systemImage: chipsData.systemImage,
//                          titleKey: chipsData.titleKey,
//                          isSelected: chipsData.isSelected)
//                        .padding(.all, 5)
//                        .alignmentGuide(.leading) { dimension in  //update leading width for available width
//                            if (abs(width - dimension.width) > geo.size.width) {
//                                width = 0
//                                height -= dimension.height
//                            }
//
//                            let result = width
//                            if chipsData.id == viewModel.dataObject.last!.id {
//                                width = 0
//                            } else {
//                                width -= dimension.width
//                            }
//                            return result
//                          }
//                        .alignmentGuide(.top) { dimension in //update chips height origin wrt past chip
//                            let result = height
//                            if chipsData.id == viewModel.dataObject.last!.id {
//                                height = 0
//                            }
//                            return result
//                        }
//                }
//            })
//        }.padding(.all, 10)
//    }
//}
