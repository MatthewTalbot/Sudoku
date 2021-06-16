//
//  BookEntity+CoreDataProperties.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-06-07.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var position: Int64
    @NSManaged public var bookToDifficulty: NSSet?

}

// MARK: Generated accessors for bookToDifficulty
extension BookEntity {

    @objc(addBookToDifficultyObject:)
    @NSManaged public func addToBookToDifficulty(_ value: DifficultyEntity)

    @objc(removeBookToDifficultyObject:)
    @NSManaged public func removeFromBookToDifficulty(_ value: DifficultyEntity)

    @objc(addBookToDifficulty:)
    @NSManaged public func addToBookToDifficulty(_ values: NSSet)

    @objc(removeBookToDifficulty:)
    @NSManaged public func removeFromBookToDifficulty(_ values: NSSet)

}

extension BookEntity : Identifiable {

}
