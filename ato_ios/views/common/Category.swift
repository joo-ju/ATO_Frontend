//
//  MarketCategory.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/19.
//

import Foundation
import SwiftUI

struct Category: View {
    let text: String
    var body: some View {
        VStack{
          
            Text(text)
                .font(.system(size: 15))
        }
        .padding(10)
        .background(Color(hex: "F2F1F1"))
        .cornerRadius(10)
        .foregroundColor(Color(hex: "838282"))
       
        
    }
}

struct Category_Previews: PreviewProvider {
    static var previews: some View {
        Category(text: "스티커")
    }
}

