//
//  ContentView.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-05-10.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BookEntity.date, ascending: true)],
        animation: .default)
    
    private var books: FetchedResults<BookEntity>

    var body: some View {
        NavigationView{
            List {
                ForEach(books) { book in
                    NavigationLink(
                        destination: SelectionView(book: book),
                        label: {
                            Text(book.name ?? "")
                        })
                }
                .onDelete(perform: deleteItems)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle("Sudokus")
            .navigationBarItems(trailing: NavigationLink(
                                    destination: addBookView(),
                                    label: {
                                        Text("Add Book")
                                    }))
        }
    }

    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }.forEach(viewContext.delete)

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
