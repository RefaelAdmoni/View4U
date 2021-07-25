//
//  Post+CoreDataProperties.swift
//  
//
//  Created by admin on 25/07/2021.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

//    @NSManaged public var date: Date?
    @NSManaged public var descriptionPlace: String?
    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var location: String?
    @NSManaged public var placeName: String?
    @NSManaged public var recommenderId: String?
    @NSManaged public var lastUpdated: Int64
    @NSManaged public var isDeletedFlag: Bool

}
