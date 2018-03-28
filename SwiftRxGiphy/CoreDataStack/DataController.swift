//
//  PersistentContainer.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/28/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import CoreData

class DataController: NSObject {
    private var сontext: NSManagedObjectContext

    override init() {
        guard let modelURL = Bundle.main.url(forResource: "EntityDataModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        сontext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        сontext.persistentStoreCoordinator = persistentStoreCoordinator

        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        
        let storeURL = docURL.appendingPathComponent("EntityDataModel.sqlite")
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
}