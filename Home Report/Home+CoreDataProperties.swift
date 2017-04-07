//
//  Home+CoreDataProperties.swift
//  Home Report
//
//  Created by Roger on 4/6/17.
//  Copyright © 2017 PFI. All rights reserved.
//

import Foundation
import CoreData


extension Home {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Home> {
        return NSFetchRequest<Home>(entityName: "Home")
    }

    @NSManaged public var price: Double
    @NSManaged public var image: NSData?
    @NSManaged public var sqft: Int16
    @NSManaged public var bed: Int16
    @NSManaged public var bath: Int16
    @NSManaged public var county: String?
    @NSManaged public var category: Category?
    @NSManaged public var location: Location?
    @NSManaged public var status: Status?

}
