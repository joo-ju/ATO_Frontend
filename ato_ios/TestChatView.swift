//
//  TestChatView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/16.
//

import Foundation
import SwiftUI
struct TestChatView: View {
    @ObservedObject var service = ChatService()
    @State var msg = ""
    var body: some View {
        VStack{
            Text("Received messages from NodeJS : ")
                .font(.title)
            
            ForEach(service.messages, id: \.self) { msg in
                Text(msg)
                    .padding()
              
            }.onAppear(perform: {
                
            })
            Spacer()
            HStack{
                TextField("Enter Message...", text: $msg)
                    .padding()
                Button(action: {
//                    service.messssages.append(msg)
                    service.sendMessage(message: msg)
             
                    msg = ""
                }, label: {
                    Image(systemName: "paperplane")
                        .padding()
                        .background(Color.gray)
                })
            }
            .background(Color.yellow)
            .padding(.bottom, 40)
           
      
        }
    }
}
