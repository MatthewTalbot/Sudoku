//
//  DifficultyEntity+CoreDataProperties.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-06-07.
//
//

import Foundation
import CoreData


extension DifficultyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DifficultyEntity> {
        return NSFetchRequest<DifficultyEntity>(entityName: "DifficultyEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var position: Int64
    @NSManaged public var difficultyToBook: BookEntity?
    @NSManaged public var difficultyToPuzzle: NSSet?

}

// MARK: Generated accessors for difficultyToPuzzle
extension DifficultyEntity {

    @objc(addDifficultyToPuzzleObject:)
    @NSManaged public func addToDifficultyToPuzzle(_ value: PuzzleEntity)

    @objc(removeDifficultyToPuzzleObject:)
    @NSManaged public func removeFromDifficultyToPuzzle(_ value: PuzzleEntity)

    @objc(addDifficultyToPuzzle:)
    @NSManaged public func addToDifficultyToPuzzle(_ values: NSSet)

    @objc(removeDifficultyToPuzzle:)
    @NSManaged public func removeFromDifficultyToPuzzle(_ values: NSSet)

}

extension DifficultyEntity : Identifiable {

}
