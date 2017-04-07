//
//  CoreData.swift
//  Home Report
//
//  Created by Andi Setiyadi on 12/31/15.
//  Copyright © 2015 PFI. All rights reserved.
//

import Foundation


import Foundation
import CoreData

/*
 The intent of creating a "standalone" CoreData.swift is to pull out the Core Data boilerplate from AppDelegate.
 Why do we do this?  For a few reason:
 * Keep AppDelegate clean and remove any unnecessary functions out
 * Core Data stack deserves to be in its own class. AppDelegate will initialize the stack and then it can inject the Core Data to view controllers.
 * If you ever need to create multiple managedObjectContext, initializing the Core Data stack is easy without having to get reference from AppDelegate and treat the Core Data as global function.
 */
class CoreData {
    let model = "Home Report"
    
    /*
     A private property, it holds the location where the Core Data will store the data.
     It will use the application document directory as the location which is the recommended place to store the data.
     */
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    /*
     A private property, represents object in the data model, including information on the model's property and its relationship.
     This is the reason we need to pass in our data model name in this property. As in this case of Home Report app,
     we name the xcdatamodeld file as "Home Report.xcdatamodeld" and that's why we pass in the same exact name to managedObjectModel.
     */
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.model, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    /*
     A private property, this coordinator is what makes things work for Core Data.
     It orchestrated the connection between the managed object model and the persistent store.
     It is responsible in doing the heavy lifting of handling Core Data implementation.
     */
    private lazy var persistenceStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(self.model)
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        }
        catch {
            fatalError("Error adding persistence store")
        }
        
        return coordinator
    }()
    
    /*
     A public property, this our only accessible property from the Core Data stack.
     It has to connect to a persistenceStoreCoordinator so we can work with the managedObject in our data store.
     It also manages the lifecycle of our objects.
     */
    lazy var managedObjectContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistenceStoreCoordinator
        return context
    }()
    
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            }
            catch {
                print("Error saving context")
                abort()
            }
        }
    }
}

