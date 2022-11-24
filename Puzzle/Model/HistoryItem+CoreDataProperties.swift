//
//  HistoryItem+CoreDataProperties.swift
//  Puzzle
//
//  Created by Gia Huy on 02/11/2022.
//
//

import Foundation
import CoreData


extension HistoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryItem> {
        return NSFetchRequest<HistoryItem>(entityName: "HistoryItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var dayComplete: Date?

}

extension HistoryItem : Identifiable {

}
