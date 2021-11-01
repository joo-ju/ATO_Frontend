//
//  ViewModel.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/25.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class ViewRouter : ObservableObject{
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    var currentPage: String = "page1" { didSet{ objectWillChange.send(self) } } }
class ViewModel: ObservableObject {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @ObservedObject var userInfo = UserInfo()
    @Published var items = [PostModel]()
    @Published var testitems = [Model]()
    @Published var goodsItems = [GoodsModel]()
    @Published var soldGoodsItems = [GoodsModel]()          // 유저가 판매완료한 게시물
    @Published var saleGoodsItems = [GoodsModel]()          // 유저가 판매중인 게시물
    @Published var hidingGoodsItems = [GoodsModel]()          // 유저가 숨김한 게시물
    @Published var buyGoodsItems = [GoodsModel]()          // 유저가 구매한 게시물
    
    @Published var detailGoodsItem = [GoodsModel]()
    @Published var oneGoodsItem: GoodsModel?
    @Published var wishGoodsItem = [GoodsModel]()           // 찜목록을 만들기위해 1개씩 받는 Goods
    @Published var wishedGoodsItems = [GoodsModel]()
    
    let prefixUrl = "http://localhost:4000"
    // let prefixUrl = "http://3.34.140.23:4000"

    // 찜 목록-> 파라미터는 유저 아이디
    func fetchWishGoodsId(parameters: String) {
        // let api = "http://3.34.140.23:4000/goods"
        let api = "http://localhost:4000/userHistory/user/wishGoods/" + parameters
        guard let url = URL(string: api) else { return }
        print("----- fetch wish goods -----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([GoodsModel].self, from: data)
                    print("\nresult------------\n", result)
                    DispatchQueue.main.async {
                        self.wishedGoodsItems = result
                        print("wishedGoodsItem ------------\n", self.wishedGoodsItems)
                        
                    }
                } else {
                    print("No data--- wishedGoodsItems")
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
    func fetchOneGoodsId(parameters: String) {
        //      let api = "https://jsonplaceholder.typicode.com/todos"
        // let api = "http://3.34.140.23:4000/goods"
        let api = "http://localhost:4000/goods/fetchOne/" + parameters
        guard let url = URL(string: api) else { return }
        print("----- fetch one goods -----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(GoodsModel.self, from: data)
                    print("\nresult------------\n", result)
                    DispatchQueue.main.async {
//                        result.forEach {
//                            print($0._id)
//                        }
                        self.oneGoodsItem = result
                        print("oneGoodsItem ------------\n", self.oneGoodsItem)
                    }
                } else {
                    print("No data--- oneGoodsItem")
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
        let api = "http://localhost:4000/goods/sale/all"
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
        guard let url = URL(string: "\(prefixUrl)/goods/user/reserve/all/" + parameters) else {
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
    
    // 로그인한 사용자의 구매완료 제품 List
    // 로그인 구현 전 : joo로 고정
    func fetchGoodsBuyBuyerId(parameters: String){
        guard let url = URL(string: "\(prefixUrl)/goods/user/buy/all/" + parameters) else {
            print("Not Found url")
            return
        }
        print("\n-----fetch User Buy Goods-----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([GoodsModel].self, from: data)
                    print("** result **\n", result)
                    DispatchQueue.main.async {
                        self.buyGoodsItems = result
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
//        print("httpBody = ", request.value(forHTTPHeaderField: Content-Type"))
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
//                        let uiImge: UIImage = image.asUIImage()
//                        let imageData = uiImge.jpegData(compressionQuality: 0.1)!
//
//                        let url = "http://localhost:4000/goods/image"
//                        AF.upload(multipartFormData: { multipartFormData in
//        //                    multipartFormData.append(imageData, withName: "image")
//                            multipartFormData.append(imageData, withName: "image", fileName: "a.jpg", mimeType: "image/jpg")
//                            print(multipartFormData)
//                        }, to: url)
//                            .responseString{response in
//                                print(response)
//
//                            }
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
    
    func updateStatus(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/goods/update/status") else {
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
                print("update status json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    func updateBuyerId(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/goods/update/buyerId") else {
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
                print("update status json error : ", JsonError.localizedDescription)
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

//.environmentObject(UserViewModel())
