//
//  keyword.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/19.
//


import Foundation
import SwiftUI

struct Keyword: View {
    let text: String
    var body: some View {
        VStack{
          
            Text(text)
                .font(.system(size: 15))
        }
        .padding(10)
        .cornerRadius(10)
        .foregroundColor(Color(hex: "8EA4D2"))
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "8EA4D2"), lineWidth: 2))
        
    }
}

struct Keyword_Previews: PreviewProvider {
    static var previews: some View {
        Keyword(text: "스티커")
    }
}
