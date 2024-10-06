//
//  CoreDataManager.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import Foundation
import CoreData

class PersistentStorageCDManager {
    static let shared = PersistentStorageCDManager()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsReader")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved Core Data error \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data save error: \(error.localizedDescription)")
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
