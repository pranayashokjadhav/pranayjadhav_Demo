//
//  SavedHoldings+CoreDataProperties.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 16/11/25.
//
//

public import Foundation
public import CoreData


public typealias SavedHoldingsCoreDataPropertiesSet = NSSet

extension SavedHoldings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedHoldings> {
        return NSFetchRequest<SavedHoldings>(entityName: "SavedHoldings")
    }

    @NSManaged public var avgPrice: Double
    @NSManaged public var close: Double
    @NSManaged public var id: UUID?
    @NSManaged public var ltp: Double
    @NSManaged public var quantity: Double
    @NSManaged public var symbol: String?

}

extension SavedHoldings : Identifiable {

}
