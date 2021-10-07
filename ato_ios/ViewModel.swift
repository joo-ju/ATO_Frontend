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
    
    let prefixUrl = "http://localhost:4000"

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
             print("No data")
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
  
//    func fetchPosts(){
//        guard let url = URL(string: "\(prefixUrl)/post") else { return }
//
//
//        URLSession.shared.dataTask(with: url) { (data, res, error) in
//
//
//            do {
//
//
//                if let data = data {
//                    let result = try JSONDecoder().decode([PostModel].self, from: data)
//                    DispatchQueue.main.async {
//                        self.items = result
//                    }
//                } else {
//                    print("No Data")
//                }
//            } catch let JsonError {
//                print("fetch : fetch json error : ", JsonError.localizedDescription)
////                print("-------------_", result)
//            }
//        }.resume()
//
//    }
//    func fetchPosts(){
//        guard let url = URL(string: "\(prefixUrl)/post/") else {
//            print("Not Found url")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, res, error) in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
////            @Published var result
//
//            do {
//
//                print("-------__", data, res, error)
//                if let data = data {
//
//                    let result = try JSONDecoder().decode(DataModel.self, from: data)
//                    print("=========", result)
//                }
//                else {
//                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!")
//                }
//
//                if let data = data {
//                    let result = try JSONDecoder().decode(DataModel.self, from: data)
//                    print("-------------_", result)
//                    DispatchQueue.main.async {
//                        self.items = result.data
//                        print("-------------_",result.data)
//                    }
//                } else {
//                    print("No Data")
//                }
//            } catch let JsonError {
//                print("fetch json error : ", JsonError.localizedDescription)
////                print("-------------_", result)
//            }
//        }.resume()
//    }
//
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
