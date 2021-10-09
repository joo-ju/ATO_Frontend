//
//  ViewModel.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/25.
//

import Foundation
import SwiftUI
//
//class ContentViewModel: ObservableObject {
//  @Published var items = [Model]()
//  func fetchData() {
//    let api = "https://jsonplaceholder.typicode.com/todos"
//    guard let url = URL(string: api) else { return }
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//      do {
//         if let data = data {
//           let result = try JSONDecoder().decode([Model].self, from: data)
//           DispatchQueue.main.async {
//              self.items = result
//           }
//         } else {
//           print("No data")
//         }
//      } catch (let error) {
//         print(error.localizedDescription)
//      }
//     }.resume()
//  }
//}

class ViewModel: ObservableObject {
    @Published var items = [PostModel]()
    @Published var testitems = [Model]()
    @Published var goodsItems = [GoodsModel]()
    @Published var soldGoodsItems = [GoodsModel]()          // 유저가 판매완료한 게시물
    @Published var saleGoodsItems = [GoodsModel]()          // 유저가 판매중인 게시물
    @Published var hidingGoodsItems = [GoodsModel]()          // 유저가 숨김한 게시물
    
    let prefixUrl = "http://localhost:4000"
    // let prefixUrl = "http://3.34.140.23:4000"
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        //      let api = "https://jsonplaceholder.typicode.com/todos"
        let api = "http://localhost:4000/post"
        guard let url = URL(string: api) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([PostModel].self, from: data)
                    
                    print("\nresult------------\n\t", result)
                    DispatchQueue.main.async {
                        self.items = result
                    }
                } else {
                    print("No data")
                }
            } catch (let error) {
                print("-------------", error.localizedDescription)
            }
        }.resume()
    }
    func fetchAllGoods() {
        //      let api = "https://jsonplaceholder.typicode.com/todos"
        // let api = "http://3.34.140.23:4000/goods"
        let api = "http://localhost:4000/goods"
        guard let url = URL(string: api) else { return }
        print("-----fetch All Goods-----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([GoodsModel].self, from: data)
                    print("\nresult------------\n", result)
                    DispatchQueue.main.async {
                        self.goodsItems = result
                    }
                } else {
                    print("No data--- all goods")
                }
            } catch (let error) {
                print("-------------", error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchOneGoodsId(parameters: String){
        guard let url = URL(string: "\(prefixUrl)/goods/fetchOne/" + parameters) else {
            print("Not Found url")
            return
        }
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(GoodsModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No Data")
                }
            } catch let JsonError {
                print("fetchOneGoodsId json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    // 로그인한 사용자의 판매중인 제품 List
    // 로그인 구현 전 : joo로 고정
    func fetchGoodsSaleSellerId(parameters: String){
        guard let url = URL(string: "\(prefixUrl)/goods/user/sale/all/" + parameters) else {
            print("Not Found url")
            return
        }
        print("\n-----fetch User Sale Goods-----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([GoodsModel].self, from: data)
                    print("** result **\n", result)
                    DispatchQueue.main.async {
                        self.saleGoodsItems = result
                    }
                } else {
                    print("No data")
                }
            } catch (let error) {
                print( error.localizedDescription)
            }
        }.resume()
    }
    
    // 로그인한 사용자의 판매완료 제품 List
    // 로그인 구현 전 : joo로 고정
    func fetchGoodsSoldSellerId(parameters: String){
        guard let url = URL(string: "\(prefixUrl)/goods/user/sold/all/" + parameters) else {
            print("Not Found url")
            return
        }
        print("\n-----fetch User Sold Goods-----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([GoodsModel].self, from: data)
                    print("** result **\n", result)
                    DispatchQueue.main.async {
                        self.soldGoodsItems = result
                    }
                } else {
                    print("No data")
                }
            } catch (let error) {
                print("!! ERROR !!\n", error.localizedDescription)
            }
        }.resume()
    }
    
    // 로그인한 사용자의 숨김 제품 List
    // 로그인 구현 전 : joo로 고정
    func fetchGoodsHidingSellerId(parameters: String){
        guard let url = URL(string: "\(prefixUrl)/goods/user/hiding/all/" + parameters) else {
            print("Not Found url")
            return
        }
        print("\n fetch User Hiding Goods ------------------------------------------------------------")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([GoodsModel].self, from: data)
                    print("** result **\n", result)
                    DispatchQueue.main.async {
                        self.hidingGoodsItems = result
                    }
                } else {
                    print("No data")
                }
            } catch (let error) {
                print("!! ERROR !!\n", error.localizedDescription)
            }
        }.resume()
    }
    
    
    // Create Data...
    func createPosts(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/post/createpost") else {
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
                    let result = try JSONDecoder().decode(PostModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No Data")
                }
            } catch let JsonError {
                print("create fetch json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
    func createGoods(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/goods/") else {
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
                    let result = try JSONDecoder().decode(GoodsModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No Data")
                }
            } catch let JsonError {
                print("create goods fetch json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    // Update Data...
    func updateGoods(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/goods/updateGoods") else {
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
                    let result = try JSONDecoder().decode(GoodsModel.self, from: data)
                    DispatchQueue.main.async {
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
    func updatePosts(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/post/updatepost") else {
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
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
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
