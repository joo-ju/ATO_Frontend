//
//  Feedback.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/10.
//  별점을 평가

import Foundation
import SwiftUI

struct FeedBack : View {
    
    @Binding var ratings : Int
//    @State var username = "joo"
//    @Binding var show : Bool
    
    var body : some View{
        
        VStack{
            
            HStack{
                Spacer()
                Text("거래는 어떠셨나요?").fontWeight(.bold)//.foregroundColor(.white)
                    .font(.system(size: 20))
                
                Spacer()
                
            }.padding(.top)
            
            HStack(spacing: 15){
                ForEach(1...5,id: \.self){i in
                    
                    Image(systemName: self.ratings == 0 ? "star" : "star.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(i <= self.ratings ? Color(hex: "8EA4D2") : Color.black.opacity(0.13))
                        .onTapGesture {
                            
                            self.ratings = i
                    }
                }
                
            }
            .padding()
        }
    }
}
