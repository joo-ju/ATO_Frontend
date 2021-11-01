//
//  TestImageView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/31.
//

import Foundation
import SwiftUI


struct TestImageView1: View {
    var body: some View {
        Image(uiImage: "http:localhost:4000/goods/image/1635579631035_a.jpg".load())
            .resizable()
            .frame(width: 150, height: 100)
        
    }
}
