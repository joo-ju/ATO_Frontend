////
////  TestChatView.swift
////  ato_ios
////
////  Created by 김주희 on 2021/10/16.
////
//
import Foundation
import SwiftUI
import Combine
import Alamofire
public struct TestImageView: View {
    
    @State var showImagePicker: Bool = false
    //    @Binding var selectedImage: Image
    @State var selectedImage: Image? = Image("")
    public var body: some View {
        VStack{
            // create button to select image
            Button(action: {
                self.showImagePicker.toggle()
            }, label: {
                Text("Select image")
            })
            
            //show image
            self.selectedImage?.resizable().scaledToFit()
            
            // show button to upload image
            Button(action: {
//
//                   let parameters : Parameters = [
//                       "newsletter_name": tfTitle.text ?? "",
//                       "newsletter_explain" : tfExplain.text ?? "",
//                       "newsletter_tags" : str,
//                       "register_url" : tfURL.text ?? ""
//                   ]
//
//                   let imageData = image.jpegData(compressionQuality: 1)!
                let uiImge: UIImage = self.selectedImage.asUIImage()
                let imageData = uiImge.jpegData(compressionQuality: 0.1)!
                
//                let imageData: Data = uiImge.jpegData(compressionQuality: 1.0) ?? Data()
                
//                print(selectedImage)
//                print(imageData)
                let url = "http://localhost:4000/goods/image"
                AF.upload(multipartFormData: { multipartFormData in
//                    multipartFormData.append(imageData, withName: "image")
                    multipartFormData.append(imageData, withName: "image", fileName: "a.jpg", mimeType: "image/jpg")
                    print(multipartFormData)
                }, to: url)
                    .responseString{response in
                        print(response)

                    }
                 

//                    .responseDecodable(of: DecodableType.self) { response in
//                        debugPrint(response)
//                    }
                
//
//
//                      upload(image: imageData, to: url, params: parameters)
//                AF.upload(multipartFormData: { multipart in
//
//                            for (key, value) in parameter {
//                                if let temp = value as? String {
//                                    multipart.append(temp.data(using .utf8)!, withName: key)
//                                }
//                                if let temp = value as? Int {
//                                    multipart.append("\(temp)".data(using: .utf8)!, withName: key)
//                                }
//                            
//                            }
//                        
//                            //IMAGE PART
//                            for image in data {
//                                multipart.append(image,
//                                            withName: "apply_img_ts",
//                                                fileName: "\(image).jpg",
//                                                    mimeType: "image/jpeg")
//                            }
//                         }, to: url
////                          , headers: headers).uploadProgress(queue: .main, closure: { progress in
////
////                        print("Upload Progress: \(progress.fractionCompleted)")
////
////                         }
//                          ).responseJSON(completionHandler: { data in
//                             switch data.result {
//                            case .success(_):
//                                do {
//                                    print("success")
//                                }
//                            case .failule(let error):
//                                print(error.localizedDescription)
//                            }
//                         })
//                AF.upload(multipartFormData: { multipartFormData in
//                    multipartFormData.append(imageData, withName: "image")
//                    //                    multipartFormData.append(Data("two".utf8), withName: "two")
//                }, to: "http://localhost:4000/goods/image")
//                    .responseDecodable(of: DecodableType.self) { response in
//                        debugPrint(response)
//                    }
                
                //                    }
                //                let uiImge: UIImage = self.selectedImage.asUIImage()
                //                print(1)
                //                let imageData: Data = uiImge.jpegData(compressionQuality: 0.5) ?? Data()
                //                print(2)
                //                let imageStr: String = imageData.base64EncodedString()
                //                print(3)
                //                let paramStr: String = "image=\(imageStr)"
                //                print(4)
                //                let paramData: Data = paramStr.data(using: .utf8) ?? Data()
                //                print(5)
                //                let request = MultipartFormDataRequest(url: URL(string: "http://localhost:4000/goods/image")!)
                //                print(6)
                //                request.addDataField(named: "image", data: imageData , mimeType: "img/jpeg")
                //                print("request = ")
                //                print("httpbody = ", request.httpBody)
                //                let URLReq = request.asURLRequest()
                //                print("URLReq = ", URLReq)
                //                URLSession.shared.dataTask(with: URLReq, completionHandler: {
                //                    (data, response, error) in
                //                    if error != nil {
                //                        print("error", error?.localizedDescription ?? "")
                //                        return
                //                    }
                //                    //                          print("request : ", request)
                //                    guard let data = data else {
                //                        print("invalid data")
                //                        return
                //                    }
                //
                //                }).resume()
                
                // conver t image to base 64
                //              let uiImge: UIImage = self.selectedImage.asUIImage()
                //              let imageData: Data = uiImge.jpegData(compressionQuality: 1.0) ?? Data()
                //              let imageStr: String = imageData.base64EncodedString()
                //
                //              // send request to server
                //              guard let url: URL = URL(string: "http://localhost:4000/goods/image") else {
                //                  print("invalid URL")
                //                  return
                //              }
                //              // create parameters
                ////              let paramStr: String = "files=[\(imageStr)]"
                //              let paramStr: String = "image=\(imageStr)"
                //              let paramData: Data = paramStr.data(using: .utf8) ?? Data()
                //              var urlRequest: URLRequest = URLRequest(url: url)
                //              urlRequest.httpMethod = "POST"
                //              urlRequest.httpBody = paramData
                //
                //              // required for sending large data
                ////              urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                //              urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
                //              // send the request
                //
                //              let boundary = "Boundary-\(UUID().uuidString)"
                //
                //              var request = URLRequest(url: URL(string: "http://localhost:4000/goods/image")!)
                //              request.httpMethod = "POST"
                //              request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                //
                //              URLSession.shared.dataTask(with: urlRequest, completionHandler: {
                //                  (data, response, error) in
                //                  guard let data = data else {
                //                      print("invalid data")
                //                      return
                //                  }
                //
                //                  // show response in string
                //                  let responseStr: String = String(data: data, encoding: .utf8) ?? ""
                //                  print(responseStr)
                //              }).resume()
                
            }, label: {
                Text("Upload Image")
            })
        }
            .sheet(isPresented: $showImagePicker , content: {
                ImagePicker(image: $selectedImage)
            })
    }
    
}


struct MultipartFormDataRequest {
    private let boundary: String = UUID().uuidString
    var httpBody = NSMutableData()
    let url: URL
    
    init(url: URL) {
        self.url = url
        print("boundary = ", boundary)
        print("httpBody = ", httpBody)
    }
    func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
        
    }
    
    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        print("fieldString: ", fieldString)
        return fieldString
    }
    
    func addDataField(named name: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }
    
    private func dataFormField(named name: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()
        
        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(data)
        fieldData.append("\r\n")
        
        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }
}

extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}


extension URLSession {
    func dataTask(with request: MultipartFormDataRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}
