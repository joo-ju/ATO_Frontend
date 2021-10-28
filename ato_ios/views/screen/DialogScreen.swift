//
//  DialogScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/22.
//

import SwiftUI
import SocketIO

class Service: ObservableObject {
    @Published var manager =  SocketManager(socketURL: URL(string:"http://localhost:8080/")!, config: [.connectParams(["EIO": "3"])])
    
    //     var manager = SocketManager(socketURL: URL( string: "http://localhost:5000")!, config: [.log(true), .compress])
    
    @Published var messages = [String]()
    @Published var writers = [String]()
    @Published var contents = [Content]()
    @ObservedObject var userInfo = UserInfo()
    init() {
        let socket = manager.defaultSocket
        socket.on(clientEvent: .connect) {
            (data, ack) in
            print("Connected")
            socket.emit("NodeJS Server Port", "Hi NodeJS Server!")
        }
        
        socket.on("iOS Client Port"){ [weak self] (data,ack) in
            if let data = data[0] as? [String: String],
               let rawMessage = data["message"] {
                DispatchQueue.main.async {
                    //                   self?.messages.append(rawMessage)
                    print("messages : ", self?.messages)
                    
                }
            }
        }
        socket.on("e1"){ [weak self] (data,ack) in
            if let data = data[0] as? [String: String],
               //              let rawMessage = data["message"]
               let rawWriter = data["writer"]{
                
                DispatchQueue.main.async {
                    self?.writers.append(rawWriter)
                    self?.messages.append(data["message"] ?? "")
                    print(self?.writers)
                    print(self?.messages)
                    //                   self?.contents.
                    
                }
            }
//            let rawMessage = data["message"]{
//
//             DispatchQueue.main.async {
//                 self?.writers.append(rawWriter)
//                 self?.messages.append(rawMessage)
//
//                 print(self?.messages)
//                 //                   self?.contents.
//
//             }
//         }
        }
        socket.connect()
    }
    
    func sendMessage(message: String, roomId: String){
        let socket = manager.defaultSocket
        let parameters = ["message": message, "roomId": roomId, "writer": self.userInfo.id]
        socket.emit("event1", parameters)
        messages.append(message)
        //        writers.append(self.userInfo.id)
        print(messages)
    }
    
    
    
    
    func receiveMessage(message: String){
        
        let socket = manager.defaultSocket
        socket.emit("e1", message)
    }
}



struct DialogScreen: View {
    
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @ObservedObject var chatService = Service()
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    var contentItems = [Content]()
    //    var content : Content
    var messages = [String]()
    let goodsId: String
    let sellerId: String
    let roomId: String
    
    @State var msg = ""
    var body: some View {
        VStack{
            ScrollView{
                
                ForEach(chatViewModel.contentItems, id: \.self) { content in
                    if content.userId == self.userInfo.id {
                        HStack{
                            Spacer()
                            Text(content.message)
                                .padding(.horizontal)
                                .padding(.vertical,10)
                                .background(Color(hex: "A9BCE8"))
                                .foregroundColor(Color(hex: "ffffff"))
                            
                                .cornerRadius(10)
                        }.padding(.leading, 60)
                            .padding(.vertical, 2)
                            .padding(.trailing, 30)
                    }
                    else {
//                    else if content.userId == chatViewModel.roomItem?.sellerId ?? ""  || content.userId == chatViewModel.roomItem?.customerId ?? ""  {
                        HStack{
                            
                            Text(content.message)
                                .padding(.horizontal)
                                .padding(.vertical,10)
                                .background(Color(hex: "F0F4FF"))
                                .foregroundColor(Color(hex: "6279B8"))
                            
                                .cornerRadius(10)
                            Spacer()
                        }.padding(.trailing, 60)
                            .padding(.vertical, 2)
                            .padding(.leading, 30)
                    }
                    //                Text(content.message)
                    //                    .padding()
                    //                    .foregroundColor(Color.red)
                    
                }.onAppear(perform: {
                    //                let manager = service.manager
                    //                let socket = manager.defaultSocket
                    //                     socket.on(clientEvent: .connect) {
                    //                         (data, ack) in
                    //                         print("Connected")
                    //                         socket.emit("NodeJS Server Port", "Hi NodeJS Server!")
                    //                     }
                })
                ForEach(chatService.writers.indices, id: \.self) { index in
                    if  self.userInfo.id == chatService.writers[index] {
                        HStack{
                            Spacer()
                            Text(chatService.messages[index])
                                .padding(.horizontal)
                                .padding(.vertical,10)
                                .background(Color(hex: "A9BCE8"))
                                .foregroundColor(Color(hex: "ffffff"))
                            
                                .cornerRadius(10)
                        }.padding(.leading, 60)
                            .padding(.vertical, 2)
                            .padding(.trailing, 30)
                    }
                    else {
                        HStack{
                            Text(chatService.messages[index])
                                .padding(.horizontal)
                                .padding(.vertical,10)
                                .background(Color(hex: "F0F4FF"))
                                .foregroundColor(Color(hex: "6279B8"))
                            
                                .cornerRadius(10)
                            Spacer()
                        }.padding(.trailing, 60)
                            .padding(.vertical, 2)
                            .padding(.leading, 30)
                    }
                    //                if content.userId == self.userInfo.id {
                    //                    HStack{
                    //                        Spacer()
                    //                        Text(content.message)
                    //                            .padding(.horizontal)
                    //                            .padding(.vertical,10)
                    //                            .background(Color(hex: "A9BCE8"))
                    //                            .foregroundColor(Color(hex: "ffffff"))
                    //
                    //                            .cornerRadius(10)
                    //                    }.padding(.leading, 60)
                    //                        .padding(.vertical, 2)
                    //                        .padding(.trailing, 30)
                    //                }
                    //                else if content.userId == chatViewModel.roomItem?.sellerId ?? ""  || content.userId == chatViewModel.roomItem?.customerId ?? ""  {
                    //                    HStack{
                    //
                    //                        Text(content.message)
                    //                            .padding(.horizontal)
                    //                            .padding(.vertical,10)
                    //                            .background(Color(hex: "F0F4FF"))
                    //                            .foregroundColor(Color(hex: "6279B8"))
                    //
                    //                            .cornerRadius(10)
                    //                        Spacer()
                    //                    }.padding(.trailing, 60)
                    //                        .padding(.vertical, 2)
                    //                        .padding(.leading, 30)
                    //                }
                    //                Text(content.message)
                    //                    .padding()
                    //                    .foregroundColor(Color.red)
                    
                }.onAppear(perform: {
                    //                let manager = service.manager
                    //                let socket = manager.defaultSocket
                    //                     socket.on(clientEvent: .connect) {
                    //                         (data, ack) in
                    //                         print("Connected")
                    //                         socket.emit("NodeJS Server Port", "Hi NodeJS Server!")
                    //                     }
                })
                Spacer()
            }
            
            HStack{
                TextField("Enter Message...", text: $msg)
                    .padding()
                Button(action: {
                    //                    service.messssages.append(msg)
                    print("Msg: ", msg)
                    chatService.sendMessage(message: msg, roomId: roomId)
                    
                    print("messages: ", messages)
                    chatViewModel.updateMessage(parameters: ["writer": self.userInfo.id, "roomId": roomId, "message": msg])
                    msg = ""
                }, label: {
                    Image(systemName: "paperplane")
                        .padding()
                        .background(Color.gray)
                })
            }
            .background(Color.yellow)
        }  .onAppear(perform: {
            
            print("\n\ngoodsId", goodsId)
            print("sellerId", sellerId)
            //            print("roomId", chatViewModel.roomItem?._id)
            let parameters: [String:Any] = ["sellerId" : sellerId, "customerId": self.userInfo.id, "goodsId": goodsId]
            
            chatViewModel.fetchChat(roomId: chatViewModel.roomItem?._id ?? "", goodsId: goodsId)
        })
        
    }
}

