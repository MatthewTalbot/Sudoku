//
//  PuzzleView.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-06-11.
//

import SwiftUI

struct PuzzleView: View{
    var puzzle: PuzzleEntity
    
    var body: some View{
        if puzzle.img != nil{
            Image(uiImage: getImage()).resizable().scaledToFit()
        }
        
    }
    
     func getImage() -> UIImage {
        let image = UIImage(data: puzzle.img!)
        return image!
    }
}
