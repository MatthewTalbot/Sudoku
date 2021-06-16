//
//  DifficultyView.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-05-11.
//

import Foundation
import SwiftUI

struct DisplayView: Identifiable{
    let id: UUID
    let name: String
    var puzzle: PuzzleEntity?
    var items: [DisplayView]?
}

struct SelectionView: View{
    var book: BookEntity
    
    var body: some View{
        let display: [DisplayView] = displayView()
        let sorted: [DifficultyEntity] = sortItems()
        
        List(display, children:\.items){ item in
            
            if item.puzzle == nil{
                Text(item.name)
            }else{
                NavigationLink(
                    destination: PuzzleView(puzzle: item.puzzle!),
                    label: {
                        Text(item.name)
                    })
            }
            
            
            
        }
        .navigationTitle(Text("Puzzles"))
        .navigationBarItems(trailing: NavigationLink(
                                destination: AddPuzzleView(sortedDifficulties: sorted),
                                label: {
                                    Text("Add Puzzle")
                                }))
    }
    
    func sortItems() -> [DifficultyEntity]{
        let difficultiesArray = book.bookToDifficulty?.allObjects as! [DifficultyEntity]
        let sortedDifficulties = difficultiesArray.sorted{
            $0.position < $1.position
        }
        return sortedDifficulties
    }
    
    func displayView() -> [DisplayView] {
        let sorted = sortItems()
        var displayView: [DisplayView] = []
        
        for difficulty in sorted {
            let puzzles = difficulty.difficultyToPuzzle?.allObjects as! [PuzzleEntity]
            
            var puzzleView: [DisplayView] = []
        
            if !puzzles.isEmpty{
                for puzzle in puzzles {
                    puzzleView.append(DisplayView(id: puzzle.id!, name: puzzle.name ?? "", puzzle: puzzle))
                }
            }
            
            displayView.append(DisplayView(id: difficulty.id!, name: difficulty.name ?? "", items: puzzleView))
        }
        return displayView
        
    }
    
}
