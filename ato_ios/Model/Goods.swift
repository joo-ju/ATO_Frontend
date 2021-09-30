//
//  Goods.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/16.
//

import Foundation


struct GoodsModel: Decodable {
    let _id:String
    let title: String
    let content: String
    let state: String
    let price: Int
    let tags: Array<String>
//    let enrollTime: Date
//    let updateTime: Date
}
//
//class Api : ObservableObject{
//    @Published var books = [Book]()
//    
//    func loadData(completion:@escaping ([Book]) -> ()) {
//        guard let url = URL(string: "https://training.xcelvations.com/temp/books.json") else {
//            print("Invalid url...")
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            let books = try! JSONDecoder().decode([Book].self, from: data!)
//            print(books)
//            DispatchQueue.main.async {
//                completion(books)
//            }
//        }.resume()
//        
//    }
//}
