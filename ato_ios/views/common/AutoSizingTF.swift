//
//  AutoSizingTF.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/28.
//  자동으로 줄바꿈 되며 스크롤 생서되는 TextField

import Foundation
import SwiftUI

//struct ResizableTF1: UIViewRepresentable {
//
//    @Binding var txt: String
//    @Binding var height: CGFloat
//
//    func makeCoordinator() -> Coordinator {
//
//        return ResizableTF.Coordinator(parent1: self)
//    }
//    func makeUIView(context: Context) -> some UITextView {
//
//        let view = UITextView()
//        view.isEditable = true
//        view.isScrollEnabled = true
//        view.text = "Enter Message..."
//        view.textColor = .gray
//        view.delegate = context.coordinator
//        return view
//    }
//    func updateUIView(_ uiView: UITextView, context: Context) {
//
//    }
//    class Coordinator : NSObject, UITextViewDelegate {
//        var parent : ResizableTF
//
//        init(parent1: ResizableTF){
//            parent = parent1
//        }
//
//        func textViewDidBeginEditing(_ textView: UITextView) {
//            if self.parent.txt == "" {
//                textView.text = ""
//                textView.textColor = .black
//            }
//        }
//
//        func textViewDidChange(_ textView: UITextView) {
//            DispatchQueue.main.async {
//                self.parent.height = textView.contentSize.height
//                self.parent.txt = textView.text
//            }
//        }
//    }
//
//
//}
struct ResizeableTextView: UIViewRepresentable{
    @Binding var text:String
    @Binding var height:CGFloat
    var placeholderText: String
    @State var editing:Bool = false
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.text = placeholderText
        textView.delegate = context.coordinator
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.font = UIFont.systemFont(ofSize: 15)
//        textView.lineSpacing
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        if self.text.isEmpty == true{
            textView.text = self.editing ? "" : self.placeholderText
            textView.textColor = self.editing ? .black : .lightGray
        }
        
        DispatchQueue.main.async {
            self.height = textView.contentSize.height
            textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        ResizeableTextView.Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate{
        var parent: ResizeableTextView
        
        init(_ params: ResizeableTextView) {
            self.parent = params
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
               self.parent.editing = true
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
               self.parent.editing = false
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
        
        
    }
    
}

struct AutoSizingTF: UIViewRepresentable {
    
    var hint: String
    @Binding var text: String
    @Binding var containerHeight: CGFloat
    var onEnd : ()->()
    
    func makeCoordinator() -> Coordinator {
        return AutoSizingTF.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView{
        
        let textView = UITextView()
        
        // line spacing
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        textView.attributedText = NSAttributedString(string: textView.text, attributes: attributes)
        
        // Displaying text as hint...
        textView.text = hint
        textView.textColor = .gray
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 17)
        // setting delegate...
        textView.delegate = context.coordinator
        
        // Input Accessory View....
        // Your own custom size....
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        toolBar.barStyle = .default
        
        // since we need done at right...
        // so using another item as spacer...
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(context.coordinator.closeKeyBoard))
//
//        toolBar.items = [spacer,doneButton]
//        toolBar.sizeToFit()
//
//        textView.inputAccessoryView = toolBar
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
        // Starting Text Field Height...
        DispatchQueue.main.async {
            if containerHeight == 0{
                containerHeight = uiView.contentSize.height
            }
        }
    }
    
    class Coordinator: NSObject,UITextViewDelegate{
        
        // To read all parent properties...
        var parent: AutoSizingTF
        
        init(parent: AutoSizingTF) {
            self.parent = parent
        }
        
        // keyBoard Close @objc Function...
        @objc func closeKeyBoard(){
         
            parent.onEnd()
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            // checking if text box is empty...
            // is so then clearing the hint...
            if textView.text == parent.hint{
                textView.text = ""
                textView.textColor = UIColor(Color.primary)
            }
        }
        
        // updating text in SwiftUI View...
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.containerHeight = textView.contentSize.height
        }
        
        // On End checking if textbox is empty
        // if so then put hint..
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == ""{
                textView.text = parent.hint
                textView.textColor = .gray
            }
        }
    }
}


