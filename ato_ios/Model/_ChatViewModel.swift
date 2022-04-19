////
////  ChatViewModel.swift
////  ato_ios
////
////  Created by 김주희 on 2021/10/16.
////
//
//import Foundation
//
//import SwiftUI
//import SocketIO
//
//class ChatService: ObservableObject {
//    
//    
//    
//    var manager =  SocketManager(socketURL: URL(string:"http://localhost:8080")!, config: [.connectParams(["EIO": "3"])])
//    
//    //     var manager = SocketManager(socketURL: URL( string: "http://localhost:5000")!, config: [.log(true), .compress])
//    
//    let prefixUrl = "http://localhost:4000"
//    // let prefixUrl = "http://3.34.140.23:4000"
//    @Published var chatItem:ChatModel?
//    @Published var contentItems = [Content]()
// var contentItem : Content
//    @Published var messages = [String]()
//    @ObservedObject var userInfo = UserInfo()
//    
//    @Published var roomItem: RoomModel?
//    //     @Published var roomId: String
//    //    init() {
//    //        let socket = manager.defaultSocket
//    
//    //            let socket = manager.socket(forNamespace: "/chatting"  )
//    //
//    //        socket.on(clientEvent: .connect) {
//    //            (data, ack) in
//    //            print("Connected")
//    //            socket.emit("NodeJS Server Port", "Hi NodeJS Server!")
//    //        }
//    //
//    //        socket.on("iOS Client Port"){ [weak self] (data,ack) in
//    //            if let data = data[0] as? [String: String],
//    //               let rawMessage = data["message"] {
//    //                DispatchQueue.main.async {
//    //                    self?.messages.append(rawMessage)
//    //
//    //                }
//    //            }
//    //        }
//    //        socket.on("joinedRoom"){ [weak self] (data,ack) in
//    //                    if let data = data[0] as? [String: String],
//    //                       let rawMessage = data["message"] {
//    //                        DispatchQueue.main.async {
//    //                            print(rawMessage)
//    //                            self?.messages.append(rawMessage)
//    //
//    //                        }
//    //                    }
//    //                }
//    //        socket.on("join"){ [weak self] (data,ack) in
//    //                    if let data = data[0] as? [String: String],
//    //                       let rawMessage = data["message"] {
//    //                        DispatchQueue.main.async {
//    //                            print(rawMessage)
//    //                            self?.messages.append(rawMessage)
//    //
//    //                        }
//    //                    }
//    //                }
//    //        socket.on("node to ios"){ [weak self] (data,ack) in
//    //                    if let data = data[0] as? [String: String],
//    //                       let rawMessage = data["message"] {
//    //                        DispatchQueue.main.async {
//    //                            print(rawMessage)
//    //                            print(data["roomId"])
//    //                            self?.messages.append(rawMessage)
//    //
//    //                        }
//    //                    }
//    //                }
//    ////        socket.on("e1"){ [weak self] (data,ack) in
//    ////            if let data = data[0] as? [String: String],
//    ////               let rawMessage = data["message"] {
//    ////                DispatchQueue.main.async {
//    ////                    self?.messages.append(rawMessage)
//    ////
//    ////                }
//    ////            }
//    ////        }
//    //        socket.connect()
//    //    }
////
////    func sendMessage(message:String, writer:String){
//////        let socket = manager.defaultSocket
////        let socket = manager.socket(forNamespace: "/chatting"  )
////            socket.emit("send Msg", ["message": message, "userId": writer])
////
////
////
////    }
////
////    func receiveMessage(message: String){
////
////        let socket = manager.defaultSocket
////        socket.emit("e1", message)
////    }
//    
//    
//    
//    //     func joinRoom(sellerId: String, customerId){
////    func joinRoom(parameters: [String: Any]){
////        let socket = manager.defaultSocket
////        //         socket.emit("create", parameters)
////        //         socket.on("iOS Client Port"){ [weak self] (data,ack) in
////        //             if let data = data[0] as? [String: String],
////        //                let rawMessage = data["message"] {
////        //                 DispatchQueue.main.async {
////        //                     self?.messages.append(rawMessage)
////        //
////        //                 }
////        //             }
////        //         }
////
////
////        //         socket.emit("joinRoom", "join ROOM")
////        //         socket.emit("testJoin", "조오오오이이이인 룸 채팅방 들어가고 싶다고!")
////        socket.emit("joinRoom", parameters)
////        print("emit joinRoom")
////
//        
////    }
//    
////    func sendMsg(parameters: [String:Any], room: String){
////        let socket = manager.socket(forNamespace: "/\(room)"  )
////
////        socket.emit("ios to node", "abcd")
////        print("/\(room)" )
////    }
////
//    func chatting(parameters: [String:Any], roomId: String){
//    
//        let socket = manager.socket(forNamespace: "/chatting"  )
//        print("\n=======")
//        
//        socket.on(clientEvent: .connect) {
//            (data, ack) in
//            print("Connected")
//            
//            print("\n=======")
//            socket.emit("NodeJS Server Port",["roomId": roomId, "sellerId": "sss"])
////            socket.
////            socket.to(roomId).emit("abc")
//            
//        }
//
//        socket.on("test"){ [weak self] (data,ack) in
//            print("-----test")
//            if let data = data[0] as? [String: String],
//               let rawMessage = data["message"] {
//                DispatchQueue.main.async {
//                    print(rawMessage)
//                    print("room receive message")
//                    self?.messages.append(rawMessage)
//                    
//                }
//            }
//        }
//        
//        socket.on("joined"){ [weak self] (data,ack) in
//            if let data = data[0] as? [String: String],
//               let rawMessage = data["message"] {
//                DispatchQueue.main.async {
//                    print(rawMessage)
//                    print("room receive message")
//                    self?.messages.append(rawMessage)
//                    
//                }
//            }
//        }
//        
//        socket.connect()
//        
//    }
//    
//    
//    
//    
//    
//    
//    // RESTful
//    func createRoom(parameters: [String: Any]){
//        guard let url = URL(string: "\(prefixUrl)/chat") else {
//            print("Not Found url")
//            return
//        }
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
//        
//        var request = URLRequest(url:url)
//        request.httpMethod = "POST"
//        request.httpBody = data
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        URLSession.shared.dataTask(with: request) { (data, res, error) in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
//            
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode(RoomModel.self, from: data)
//                    DispatchQueue.main.async {
//                        //                         print(result)
//                        //                         self.roomItem = result
//                        //                         print(self.roomItem)
//                    }
//                } else {
//                    print("No Data")
//                }
//            } catch let DecodingError.dataCorrupted(context) {
//                print(context)
//            } catch let DecodingError.keyNotFound(key, context) {
//                print("Key '\(key)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.valueNotFound(value, context) {
//                print("Value '\(value)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.typeMismatch(type, context)  {
//                print("Type '\(type)' mismatch:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch {
//                print("error: ", error)
//            }
//        }.resume()
//        
//        
//    }
//    func fetchRoom(sellerId:String, goodsId: String, customerId: String) {
//        // let api = "http://3.34.140.23:4000/goods"
//        let api = "http://localhost:4000/chat/one/" + sellerId + "/" + goodsId + "/" + customerId
//        guard let url = URL(string: api) else { return }
//        print("-----fetch roomItem-----")
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode(RoomModel.self, from: data)
//                    print("\nresult------------\n", result)
//                    DispatchQueue.main.async {
//                        //                        result.forEach {
//                        //                            print($0._id)
//                        //                        }
//                        self.roomItem = result
//                        print("roomItem------------", self.roomItem)
//                    }
//                } else {
//                    print("No data--- room")
//                }
//            } catch let DecodingError.dataCorrupted(context) {
//                print(context)
//            } catch let DecodingError.keyNotFound(key, context) {
//                print("Key '\(key)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.valueNotFound(value, context) {
//                print("Value '\(value)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.typeMismatch(type, context)  {
//                print("Type '\(type)' mismatch:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch {
//                print("error: ", error)
//            }
//        }.resume()
//    }
//    
//    func fetchChat(roomId: String, goodsId: String){
//        // let api = "http://3.34.140.23:4000/goods"
//        let api = "http://localhost:4000/chat/chat/" + roomId + "/" + goodsId
//        guard let url = URL(string: api) else { return }
//        print("-----fetch chatItem-----")
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode([Content].self, from: data)
//                    print("\nresult------------\n", result)
//                    DispatchQueue.main.async {
////                        self.chatItem = result
//                        self.contentItems = result
//                        print("contentItems------------", self.contentItems)
//                    }
//                } else {
//                    print("No data--- room")
//                }
//            } catch let DecodingError.dataCorrupted(context) {
//                print(context)
//            } catch let DecodingError.keyNotFound(key, context) {
//                print("Key '\(key)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.valueNotFound(value, context) {
//                print("Value '\(value)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.typeMismatch(type, context)  {
//                print("Type '\(type)' mismatch:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch {
//                print("error: ", error)
//            }
//        }.resume()
//    }
//}
