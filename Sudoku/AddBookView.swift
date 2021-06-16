//
//  AddBookView.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-05-11.
//

import Foundation
import SwiftUI

struct addBookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var bookName: String = ""
    @State var newDifficultyName: String = ""
    @State var difficultiesArray: [DifficultyEntity] = []
    
    var body: some View{
        Form {
            Section(header: Text("Book Name")){
                TextField("Book Name", text: $bookName)
            }
            Section(header: EditButton().frame(maxWidth: .infinity, alignment: .trailing)
                        .overlay(Text("Difficulties"), alignment: .leading)){
                TextField("New Difficulty", text: $newDifficultyName)
                List{
                    ForEach(difficultiesArray){difficulty in
                        Text(difficulty.name ?? "")
                    }
                    .onMove(perform: move)
                    .onDelete(perform: deleteItems)
                }
                Button(action: {
                    let newDifficulty = addNewDifficulty(name: newDifficultyName)
                    difficultiesArray.append(newDifficulty)
                    newDifficultyName = ""
                }, label: {
                    Text("Add Difficulty")
                })
                
            }
            
            Button(action: {
                let book = addNewBook(name: bookName)
                for difficulty in difficultiesArray {
                    book.addToBookToDifficulty(difficulty)
                }
                bookName = ""
                save()
            }, label: {
                Text("Save")
            })
            .navigationTitle("Add New Book")
            
        }.onAppear(){
            difficultiesArray = defaultDifficulties()
            newDifficultyName = ""
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        difficultiesArray.remove(atOffsets: offsets)
        reposition()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        difficultiesArray.move(fromOffsets: source, toOffset: destination)
        reposition()
        
    }
    
    func reposition(){
        if difficultiesArray.isEmpty{ return}
        for i in 0...difficultiesArray.count - 1 {
            difficultiesArray[i].position = Int64(i)
        }
    }
    
    func addNewBook(name: String) -> BookEntity {
        let newBook = BookEntity(context: viewContext)
        newBook.name = name
        newBook.id = UUID()
        newBook.date = Date()
        return newBook
    }
    
    func addNewDifficulty(name: String) -> DifficultyEntity{
        let newDifficulty = DifficultyEntity(context: viewContext)
        newDifficulty.name = name
        newDifficulty.id = UUID()
        newDifficulty.date = Date()
        newDifficulty.position = Int64(difficultiesArray.endIndex)
        return newDifficulty
    }
    
    func defaultDifficulties() -> [DifficultyEntity]{
        let easyDifficulty = DifficultyEntity(context: viewContext)
        easyDifficulty.name = "Easy"
        easyDifficulty.id = UUID()
        easyDifficulty.date = Date()
        easyDifficulty.position = 0
        
        let mediumDifficulty = DifficultyEntity(context: viewContext)
        mediumDifficulty.name = "Medium"
        mediumDifficulty.id = UUID()
        mediumDifficulty.date = Date()
        mediumDifficulty.position = 1
        
        
        let hardDifficulty = DifficultyEntity(context: viewContext)
        hardDifficulty.name = "Hard"
        hardDifficulty.id = UUID()
        hardDifficulty.date = Date()
        hardDifficulty.position = 2
        
        let expertDifficulty = DifficultyEntity(context: viewContext)
        expertDifficulty.name = "Expert"
        expertDifficulty.id = UUID()
        expertDifficulty.date = Date()
        expertDifficulty.position = 3
        
        return [easyDifficulty, mediumDifficulty, hardDifficulty, expertDifficulty]
        
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
