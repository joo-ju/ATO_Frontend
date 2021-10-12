//
//  ReviewViewModel.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/10.
//  중고거래, 이벤트 리뷰 관리

import Foundation
import SwiftUI
class ReviewViewModel: ObservableObject {
    @Published var reviewGoodsItems = [ReviewGoodsModel]()
    
    let prefixUrl = "http://localhost:4000"
    // let prefixUrl = "http://3.34.140.23:4000"

    // Create Data...
    func createReveiwGoods(parameters: [String: Any]){
        guard let url = URL(string: "\(prefixUrl)/reviewGoods/") else {
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
                    let result = try JSONDecoder().decode(ReviewGoodsModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No Data")
                }
            } catch let JsonError {
                print("create reviewGoods json error : ", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    // Update Data...
}
