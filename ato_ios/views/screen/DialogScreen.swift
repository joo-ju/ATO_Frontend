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
                   self?.messages.append(rawMessage)

               }
           }
       }
       socket.on("e1"){ [weak self] (data,ack) in
           if let data = data[0] as? [String: String],
//              let rawMessage = data["message"]
           let rawWriter = data["writer"]{
               DispatchQueue.main.async {
                   self?.writers.append(rawWriter)
//                   self?.contents.

               }
           }
       }
       socket.connect()
   }
    
    func sendMessage(message: String, roomId: String){
        let socket = manager.defaultSocket
        let parameters = ["message": message, "roomId": roomId, "writer": self.userInfo.id]
        socket.emit("event1", parameters)
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
                else if content.userId == chatViewModel.roomItem?.sellerId ?? ""  || content.userId == chatViewModel.roomItem?.customerId ?? ""  {
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
                Text(chatService.writers[index])
                    .padding()
              
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
                    chatService.sendMessage(message: msg, roomId: chatViewModel.roomItem?._id ?? "")
                    chatViewModel.updateMessage(parameters: ["writer": self.userInfo.id, "roomId": chatViewModel.roomItem?._id ?? "", "message": msg])
                    msg = ""
                }, label: {
                    Image(systemName: "paperplane")
                        .padding()
                        .background(Color.gray)
                })
            }
            .background(Color.yellow)
//            HStack{
//            Button(action: {
//                //                let nowDate = Date() // 현재의 Date (ex: 2020-08-13 09:14:48 +0000)
//                //                let dateFormatter = DateFormatter()
//                //                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // 2020-08-13 16:30
//                //                let sendTime = dateFormatter.string(from: nowDate)
//                //
//                //                @State var content:Content
//                //
//                //                content.message = "메세지 내용"
//                //                content.userId = self.userInfo.id
//                //                content.sendTime = sendTime
//                //                chatViewModel.contentItems.append(content)
//                //
//                //                let socket = manager.socket(forNamespace: "/chatting"  )
//                //                socket.on("e1"){ (data,ack) in
//                //                    if let data = data[0] as? [String: String],
//                //                       let rawMessage = data["message"] {
//                //                        DispatchQueue.main.async {
//                //                            messages.append(rawMessage)
//                //
//                //                        }
//                //                    }
//                //                }
//                //                print("새로운 메세지 chatViewModel.contentItems에 추가 : \n", chatViewModel.contentItems)
////
////                chatService.sendMessage(message: "메에에에로오옹")
//            }, label: {
//                Image(systemName: "paperplane")
//                    .padding()
//                    .background(Color.gray)
//            })
//            }
        }  .onAppear(perform: {
            
            print("\n\ngoodsId", goodsId)
            print("sellerId", sellerId)
            //            print("roomId", chatViewModel.roomItem?._id)
            let parameters: [String:Any] = ["sellerId" : sellerId, "customerId": self.userInfo.id, "goodsId": goodsId]
         
                        chatViewModel.fetchChat(roomId: chatViewModel.roomItem?._id ?? "", goodsId: goodsId)
        })
        
    }
}

