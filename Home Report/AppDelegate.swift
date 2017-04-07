//
//  AppDelegate.swift
//  Home Report
//
//  Created by Andi Setiyadi on 12/13/15.
//  Copyright © 2015 PFI. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let coreData = CoreData()
        let managedObjectContext = coreData.managedObjectContext
        
        let tabController = self.window?.rootViewController as! UITabBarController
        
        let firstNavController = tabController.viewControllers![0] as! UINavigationController
        let firstViewController = firstNavController.topViewController as! FirstViewController
        firstViewController.managedObjectContext = managedObjectContext
        
        let secondNavController = tabController.viewControllers![1] as! UINavigationController
        let secondViewController = secondNavController.topViewController as! SecondViewController
        secondViewController.managedObjectContext = managedObjectContext
        
        deleteRecords()
        checkCoreDataStore()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func checkCoreDataStore(){
        let coreData = CoreData();
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Home");
        do
         {
            let homeCount = try coreData.managedObjectContext.count(for: request);
            print("Total Home : \(homeCount)");
            if homeCount == 0{
                uploadSampleData()
            }
        }
        catch{
            fatalError("Error in Counting Data");
        }
        
        
    }
    
    func uploadSampleData(){
        let coreData = CoreData()
        
        let url = Bundle.main.url(forResource: "sample", withExtension: "json")
        let data = NSData(contentsOf: url!)
        
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            let jsonArray = jsonResult[ "home"]! as! NSArray
            //jsonResult.i
            
            for json in jsonArray {
                let home = NSEntityDescription.insertNewObject(forEntityName: "Home", into: coreData.managedObjectContext) as! Home
                
                home.price = ((json as AnyObject)["price"] as? Double)!
                home.bed = (json as AnyObject)["bed"] as? NSNumber as! Int16
                home.bath = (json as AnyObject)["bath"] as? NSNumber as! Int16
                home.sqft = (json as AnyObject)["sqft"] as? NSNumber as! Int16
                
                let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: coreData.managedObjectContext) as! Category
                category.homeType = ((json as AnyObject)["category"] as! NSDictionary)["homeType"] as? String
                home.category = category
                
                let status = NSEntityDescription.insertNewObject(forEntityName: "Status", into: coreData.managedObjectContext) as! Status
                let isForSale = ((json as AnyObject)["status"] as! NSDictionary)["isForSale"] as! Bool
                status.isForSale =  NSNumber(value: isForSale) as! Bool
                home.status = status
                
                let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: coreData.managedObjectContext) as! Location
                location.city = (json as AnyObject)["city"] as? String
                home.location = location
                
                let imageName = (json as AnyObject)["image"] as? String
                let image = UIImage(named: imageName!)
                let imageData = UIImageJPEGRepresentation(image!, 1)
                
                home.image = imageData! as NSData
            }
            
            coreData.saveContext()
            
            //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Home")
            //let homeCount = coreData.managedObjectContext.countForFetchRequest(request, error: NSErrorPointer.init())
            //print("Total home: \(homeCount)")
            checkCoreDataStore();
        }
        catch {
            fatalError("Cannot upload sample data")
        }
    }
    
    
    func deleteRecords() {
        let coreData = CoreData()
        let homeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Home")
        let categoryRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let statusRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
        let locationRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        do {
            let homeResults = try coreData.managedObjectContext.fetch(homeRequest) as! [Home]
            for home in homeResults {
                coreData.managedObjectContext.delete(home)
            }
            
            let categoryResults = try coreData.managedObjectContext.fetch(categoryRequest) as NSArray
            for category in categoryResults {
                coreData.managedObjectContext.delete(category as! NSManagedObject)
            }
            
            let statusResults = try coreData.managedObjectContext.fetch(statusRequest) as! [Status]
            for status in statusResults {
                coreData.managedObjectContext.delete(status)
            }
            
            let locationResults = try coreData.managedObjectContext.fetch(locationRequest) as! [Location]
            for location in locationResults {
                coreData.managedObjectContext.delete(location)
            }
            
            coreData.saveContext()
            
            checkCoreDataStore();

        }
        catch {
            fatalError("Error deleting objects")
        }
    }


}

