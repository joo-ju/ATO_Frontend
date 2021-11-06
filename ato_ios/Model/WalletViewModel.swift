//
//  WalletViewModel.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/31.
//

import Foundation
import SwiftUI

class WalletViewModel: ObservableObject {
    
    @ObservedObject var userInfo = UserInfo()
    @Published var walletItem: WalletModel?
    @Published var walletHistoryItems = [WalletContentModel]()
    
    let prefixUrl = "http://localhost:4000"
    
    func createWallet(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/wallet/") else {
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
                    let result = try JSONDecoder().decode(WalletModel.self, from: data)
                    self.userInfo.wallet = result._id
                    DispatchQueue.main.async {
                        print("result = ", result)
                        self.userInfo.wallet = result._id
                        print(self.userInfo.wallet)
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
    func fetchOneWallet() {
        //      let api = "https://jsonplaceholder.typicode.com/todos"
        // let api = "http://3.34.140.23:4000/goods"
        let api = "\(prefixUrl)/wallet/" + self.userInfo.wallet
        guard let url = URL(string: api) else { return }
        print("----- fetch one wallet -----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(WalletModel.self, from: data)
                    print("\nresult------------\n", result)
                    DispatchQueue.main.async {
                        self.walletItem = result
                        print("walletItem ------------\n", self.walletItem)
                    }
                } else {
                    print("No data--- walletItem")
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
    func fetchWalletHistory() {
        //      let api = "https://jsonplaceholder.typicode.com/todos"
        // let api = "http://3.34.140.23:4000/goods"
        let api = "\(prefixUrl)/wallet/history/" + self.userInfo.wallet
        guard let url = URL(string: api) else { return }
        print("----- fetch wallet history -----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([WalletContentModel].self, from: data)
                    print("\nresult------------\n", result)
                    DispatchQueue.main.async {
                        self.walletHistoryItems = result
                        print("walletHistoryItems ------------\n", self.walletHistoryItems)
                    }
                } else {
                    print("No data--- walletHistoryItems")
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
    func updateWallet(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/wallet/updateWallet") else {
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
                    let result = try JSONDecoder().decode(WalletModel.self, from: data)
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
