//
//  Status+CoreDataProperties.swift
//  Home Report
//
//  Created by Roger on 4/6/17.
//  Copyright © 2017 PFI. All rights reserved.
//

import Foundation
import CoreData


extension Status {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Status> {
        return NSFetchRequest<Status>(entityName: "Status")
    }

    @NSManaged public var isForSale: Bool
    @NSManaged public var home: Home?

}
