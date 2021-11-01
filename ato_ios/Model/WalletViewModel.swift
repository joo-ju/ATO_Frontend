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
}
