//
//  UserViewModel.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/12.
//  로그인, 회원가입 등 처리

import Foundation
import SwiftUI
class UserViewModel: ObservableObject {
    @ObservedObject var userInfo = UserInfo()
    @Published var userRegisterModel = [UserRegisterModel]()
    @Published var userModel = [UserModel]()
    @Published var userHistoryItem: UserHistoryModel?
    
    
    let prefixUrl = "http://localhost:4000"
    
    // User Register...
    func createUser(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/user/signup") else {
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
                    let result = try JSONDecoder().decode(UserRegisterModel.self, from: data)
                    DispatchQueue.main.async {
//                        self.userInfo.id = result._id
                        print(result)
                    }
                } else {
                    print("No Data")
                }
            } catch let JsonError {
                print("create create User json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    // User Login...
    
    func loginUser(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/user/login") else {
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
             
//                print(a)
                if let data = data {
                    let result = try JSONDecoder().decode(UserModel.self, from: data)
          
                    
                    self.userInfo.id = result.user.id
                    self.userInfo.username = result.user.username
                    print(self.userInfo.username)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No Data")
                }
//            } catch let JsonError {
//                print("create login User json error : ", JsonError.localizedDescription)
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
    
    
    
    func fetchUserHistory(parameters: String) {
        //      let api = "https://jsonplaceholder.typicode.com/todos"
        // let api = "http://3.34.140.23:4000/goods"
        let api = "http://localhost:4000/userHistory/user/wishGoods/" + parameters
        guard let url = URL(string: api) else { return }
        print("-----fetch UserHistory-----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(UserHistoryModel.self, from: data)
                    print("\nresult------------\n", result)
                    DispatchQueue.main.async {
//                        result.forEach {
//                            print($0._id)
//                        }
                        self.userHistoryItem = result
                        print("userHistoryItem------------\n", self.userHistoryItem)
                    }
                } else {
                    print("No data--- userhistory")
                }
//            } catch (let error) {
//                print("-------------", error.localizedDescription)
//            }
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
    
    // userhistory wish에 goods 추가
    func createUserHistoryWish(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/userHistory/wishGoods") else {
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
                    let result = try JSONDecoder().decode(UserHistoryModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No Data")
                }
            } catch let JsonError {
                print("UserHistory에 wishGoods 추가 json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
    // userhistory wish에 goods 제거
    func deleteUserHistoryWish(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/userHistory/wishGoods/delete") else {
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
                    let result = try JSONDecoder().decode(UserHistoryModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No Data")
                }
            } catch let JsonError {
                print("UserHistory에 wishGoods 추가 json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
    // 찜한 Goods 1개 조회
//    func fetchOneGood(parameters:String){
//        guard let url = URL(string: "\(prefixUrl)/goods/one/" + parameters) else {
//            print("Not Found url")
//            return
//        }
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
//
//        var request = URLRequest(url:url)
//        request.httpMethod = "PUT"
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
//                    let result = try JSONDecoder().decode(UserHistoryModel.self, from: data)
//                    DispatchQueue.main.async {
//                        print(result)
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
//    }
}


