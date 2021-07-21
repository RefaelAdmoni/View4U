//
//  User+CoreDataProperties.swift
//  View4U
//
//  Created by admin on 21/07/2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?

}

extension User : Identifiable {

}
