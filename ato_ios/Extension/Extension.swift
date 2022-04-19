//
//  Extension.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/08.
//

import SwiftUI
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    static func endEditing(){
        UIApplication.shared.windows.forEach{$0.endEditing(false)}
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
            
        } else {
            return nil
            
        }
    }
    
}
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
        
    }
    
}

extension String {
    func load() -> UIImage{
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
            
        } catch {
            
        }
        return UIImage()
    }
}
//extension TextField {
//func textFieldDidChangeSelection(_ textField: UITextField) {
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .decimal
//    formatter.locale = .current
//    formatter.maximumFractionDigits = 0
//    
//    //textField.text = formatter.number(from: self.numInput!)
//    print("numInput: \(self.numInput)")
//    if self.inputDeleteFlag {
//        if let formattedNumber = formatter.number(from:     String(self.numInput!)),
//           let formattedString = formatter.string(from: formattedNumber){
//            print("FFFFFFFF : \(formattedString)")
//            textField.text = formattedString
//        }
//    }
//    print("TEXTFIELD DID CHANGE SELECTION : \(textField.text!)")
//}
//
//
//func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//    self.isComparable = false
//    
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .decimal
//    formatter.locale = Locale.current
//    formatter.maximumFractionDigits = 0//소숫점은 없어요
//    
//    if (string.first == "0" && textField.text == "") {
//        print("0은 앞에 올 수 없어")
//        return false
//    } else {
//        
//        if (!(minTextField.text!.isEmpty) && !(maxTextField.text!.isEmpty)) {
//            self.isComparable = true
//        } else {
//            self.isComparable = false
//        }
//
//
//        if let removeAllSeperator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: "") {
//            
//            //print("RemoveAllSeperator : \(removeAllSeperator)")//그냥 쉼표없는 쌩값임 ex) 123456
//            
//            var beforeFormattedString = removeAllSeperator + string
//            //쌓이는값 + 현재누른값(string) = beforeFormattedString
//            print("\n\n removeAllSeperatoe : \(removeAllSeperator), string : \(string) \n beforeFormattedString : \(beforeFormattedString)\n" )
//            
//            print("formatter.number(from: string) : \(formatter.number(from: string))")
//            
//            if formatter.number(from: string) != nil {//누른 값이 있다면!
//                
//                self.inputDeleteFlag = false
//                if let formattedNumber = formatter.number(from: beforeFormattedString),
//                   let formattedString = formatter.string(from: formattedNumber) {
//                    
//                    print("formattedNumber : \(formattedNumber)")
//                    print("formattedString : \(formattedString)")
//                    
//                    textField.text = formattedString
//                    return false
//                }
//            } else {//지운다면!
//                self.inputDeleteFlag = true
//                self.numInput = String(beforeFormattedString.dropLast())
//
//                
//            }
//            
//        
//
//        }
//        
//        
//        return true
//    }
//}
//
//}
