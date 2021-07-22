//
//  Post+CoreDataProperties.swift
//  View4U
//
//  Created by admin on 20/07/2021.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var placeName: String?
    @NSManaged public var location: String?
    @NSManaged public var descriptionPlace: String?
    @NSManaged public var date: Date?
    @NSManaged public var imageUrl: String?
    @NSManaged public var recommenderId: String?

}

extension Post : Identifiable {

}
