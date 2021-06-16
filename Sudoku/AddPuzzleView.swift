//
//  AddPuzzleView.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-06-01.
//

import SwiftUI
import Vision

struct AddPuzzleView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var image: Image?
    @State var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State var puzzleName = ""
    var sortedDifficulties: [DifficultyEntity]
    @State var selectedDifficulty: DifficultyEntity?
    
    var body: some View{
        Form{
            Section(header: Text("Puzzle Name")){
                TextField("Puzzle Name", text: $puzzleName)
            }
            
            Section(header: Text("Select Puzzle")){
                Button(action: {
                    showingImagePicker.toggle()
                    sourceType = .photoLibrary
                }, label: {Text("Photo Library")})
                
                Button(action: {
                    showingImagePicker.toggle()
                    sourceType = .camera
                }, label: {Text("Camera")})
            }
            Section(header: Text("Photo Preview")){
                if image != nil {
                    image?.resizable().scaledToFit()
                }
            }
            Section(header: Text("Puzzle Preview")){
                Text(getText())
            }
    
            Section(header: Text("Puzzle Difficulty")){
                ForEach(sortedDifficulties){ difficulty in
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: selectedDifficulty == difficulty ?
                                "checkmark.circle" : "circle")
                                .foregroundColor(.blue)
                            Text(difficulty.name ?? "")
                            Spacer()
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedDifficulty = difficulty
                    }
                    
                }
            }
            
            Button(action: {
                addNewPuzzle()
                save()
                
            }, label: {
                Text("Save")
            })
            
            
        }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(image: $inputImage, sourceType: sourceType)
            }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func getText() -> String{
        var imageText: String = ""
        guard let cgImage = inputImage?.cgImage else { return ""}
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest(completionHandler: {request, error in
            
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else { return }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ", ")
            
            imageText = text
        })
        
        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        
        return imageText
        
        
    }
    
    func addNewPuzzle(){
        let newPuzzle = PuzzleEntity(context: viewContext)
        newPuzzle.name = puzzleName
        newPuzzle.id = UUID()
        newPuzzle.date = Date()
        newPuzzle.img = inputImage?.jpegData(compressionQuality: 1)
        
        if selectedDifficulty != nil{
            selectedDifficulty!.addToDifficultyToPuzzle(newPuzzle)
        }
    }
    
    func save(){
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
