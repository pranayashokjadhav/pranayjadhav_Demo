//
//  PMCoreData.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 16/11/25.
//

import CoreData
import UIKit

class PMCoreDataManager {

    static let shared = PMCoreDataManager()

    let container: NSPersistentContainer
    let context: NSManagedObjectContext

    private init() {
        container = NSPersistentContainer(name: "Portfolio_Manager")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData load error: \(error)")
            }
        }
        context = container.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("CoreData save error:", error)
            }
        }
    }
}

extension PMCoreDataManager {
    
    func addHolding(data: [PMUserHolding]) {
        data.forEach { data in
            let holdingItem = SavedHoldings(context: context)
            holdingItem.symbol = data.symbol
            holdingItem.quantity = Double(data.quantity ?? 0)
            holdingItem.ltp = data.ltp ?? 0
            holdingItem.avgPrice = data.avgPrice ?? 0
            holdingItem.close = data.close ?? 0
            saveContext()
        }
    }

    func getAllHoldings() -> [SavedHoldings] {
        let request: NSFetchRequest<SavedHoldings> = SavedHoldings.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedHoldings")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Error deleting: SavedHoldings")
        }
    }
}
