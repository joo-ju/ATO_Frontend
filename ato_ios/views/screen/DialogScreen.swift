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
                    print("messages : ", self?.messages)
                    
                }
            }
        }
        socket.on("e1"){ [weak self] (data,ack) in
            if let data = data[0] as? [String: String],
               let rawWriter = data["writer"]{
                
                DispatchQueue.main.async {
                    self?.writers.append(rawWriter)
                    self?.messages.append(data["message"] ?? "")
                }
            }
        }
        socket.connect()
    }
    func sendMessage(message: String, roomId: String){
        let socket = manager.defaultSocket
        let parameters = ["message": message, "roomId": roomId, "writer": self.userInfo.id]
        socket.emit("event1", parameters)
        print(messages)
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
    
    @State var text = ""
    
    @State var containerHeight: CGFloat = 0
    @State var msg = ""
    
    @State var height: CGFloat = 0
    
    @State var textViewValue = String()
    @State var textViewHeight:CGFloat = 50.0
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
                }.onAppear(perform: {
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
                    
                }.onAppear(perform: {
                })
                Spacer()
            }
            HStack{
                ResizeableTextView(text: $msg, height: $textViewHeight, placeholderText: "Enter Message...").frame(height: textViewHeight < 70 ? self.textViewHeight : 70).cornerRadius(50)
        
                    
                    .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.gray, lineWidth: 0.5))
                Button(action: {
                    print("Msg: ", msg)
                    chatService.sendMessage(message: msg, roomId: roomId)
                    
                    print("messages: ", messages)
                    chatViewModel.updateMessage(parameters: ["writer": self.userInfo.id, "roomId": roomId, "message": msg])
                    msg = ""
                    
                    DialogScreen.endEditing()
                    msg = ""
                }){
                    
                    Image(systemName: "paperplane")
                        .padding()
                        .foregroundColor(.black)
                }
            }
            .padding(5)
                .padding(.leading, 15)
                .background(Color(hex: "F2F1F1"))
            
            
        }  .onAppear(perform: {
            
            print("\n\ngoodsId", goodsId)
            print("sellerId", sellerId)

            let parameters: [String:Any] = ["sellerId" : sellerId, "customerId": self.userInfo.id, "goodsId": goodsId]
            
            chatViewModel.fetchChat(roomId: chatViewModel.roomItem?._id ?? "", goodsId: goodsId)
        })
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: leading)
        
        
        
    }
    var leading: some View{
        Button(action:{
            chatService.messages = []
            chatService.writers = []
            chatService.contents = []
            
            presentationMode.wrappedValue.dismiss()
        } , label: {
            Text("닫기")
                .padding()
                .foregroundColor(Color(hex: "838383"))
                .onAppear(perform: {
                    print(goodsId)
                })
        })
    }
}
