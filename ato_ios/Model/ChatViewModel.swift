//
//  ChatViewModel.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/24.
//

import Foundation
import SocketIO
import SwiftUI


class ChatViewModel: ObservableObject {
    @Published var manager =  SocketManager(socketURL: URL(string:"http://localhost:8080")!, config: [.connectParams(["EIO": "3"])])
    
    
    @Published var contentItems = [Content]()
    @Published var messages = [String]()
    @Published var chatItem:ChatModel?
    @Published var roomItem: RoomModel?
    
    let prefixUrl = "http://localhost:4000"
    // let prefixUrl = "http://3.34.140.23:4000"
    
 
    
    
    func createRoom(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/chat") else {
            print("Not Found url")
            return
        }
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(RoomModel.self, from: data)
                    DispatchQueue.main.async {
                        //                         print(result)
                        //                         self.roomItem = result
                        //                         print(self.roomItem)
                    }
                } else {
                    print("No Data")
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
        
        
    }
    func fetchChat(roomId: String, goodsId: String){
        // let api = "http://3.34.140.23:4000/goods"
        let api = "http://localhost:4000/chat/chat/" + roomId + "/" + goodsId
        guard let url = URL(string: api) else { return }
        print("-----fetch chatItem-----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([Content].self, from: data)
                    print("\nresult------------\n", result)
                    DispatchQueue.main.async {
                        //                        self.chatItem = result
                        self.contentItems = result
                        print("contentItems------------", self.contentItems)
                    }
                } else {
                    print("No data--- room")
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
    
        func fetchRoom(sellerId:String, goodsId: String, customerId: String) {
            // let api = "http://3.34.140.23:4000/goods"
            let api = "http://localhost:4000/chat/one/" + sellerId + "/" + goodsId + "/" + customerId
            guard let url = URL(string: api) else { return }
            print("-----fetch roomItem-----")
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode(RoomModel.self, from: data)
                        print("\nresult------------\n", result)
                        DispatchQueue.main.async {
                            self.roomItem = result
                            print("roomItem------------", self.roomItem)
                        }
                    } else {
                        print("No data--- room")
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }.resume()
        }
    
    func updateMessage(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/chat/message") else {
            print("Not Found url")
            return
        }
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(ChatModel.self, from: data)
                    DispatchQueue.main.async {
                        print("채팅 내용 추가")
                        print(result)
                    }
                } else {
                    print("No Data")
                }
            } catch let JsonError {
                print("update fetch json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
}

