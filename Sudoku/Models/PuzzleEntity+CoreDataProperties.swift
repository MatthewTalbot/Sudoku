//
//  PuzzleEntity+CoreDataProperties.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-06-07.
//
//

import Foundation
import CoreData


extension PuzzleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PuzzleEntity> {
        return NSFetchRequest<PuzzleEntity>(entityName: "PuzzleEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var img: Data?
    @NSManaged public var name: String?
    @NSManaged public var position: Int64
    @NSManaged public var puzzleToDifficulty: DifficultyEntity?

}

extension PuzzleEntity : Identifiable {

}
