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
    
    @Published var oneReviewGoodsItem: ReviewGoodsModel?
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
    
    // Fetch Data...
    func fetchOneReviewGoods(userId: String, goodsId: String) {
        //      let api = "https://jsonplaceholder.typicode.com/todos"
        // let api = "http://3.34.140.23:4000/goods"
        let api = "http://localhost:4000/reviewGoods/user/one/" + userId + "/" + goodsId
        guard let url = URL(string: api) else { return }
        print("----- fetch one reviewGoods -----")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(ReviewGoodsModel.self, from: data)
                    print("\nresult------------\n", result)
                    DispatchQueue.main.async {
                        self.oneReviewGoodsItem = result
                    }
                } else {
                    print("No data--- oneGoodsItem")
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
    // Update Data...
}
