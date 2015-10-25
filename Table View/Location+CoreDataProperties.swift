//
//  Location+CoreDataProperties.swift
//  Table View
//
//  Created by Arin Houck on 10/19/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {
    
    @NSManaged var name: String?
    @NSManaged var desc: String?
    @NSManaged var imageName: String?

}
