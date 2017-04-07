//
//  Category+CoreDataProperties.swift
//  Home Report
//
//  Created by Roger on 4/6/17.
//  Copyright © 2017 PFI. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var homeType: String?
    @NSManaged public var home: Home?

}
