//
//  ImagePicker.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-06-02.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @State var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiView: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func  makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
