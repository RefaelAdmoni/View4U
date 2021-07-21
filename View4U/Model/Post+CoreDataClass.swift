//
//  Post+CoreDataClass.swift
//  View4U
//
//  Created by admin on 20/07/2021.
//
//

import Foundation
import UIKit
import CoreData

@objc(Post)
public class Post: NSManagedObject {

    static func create(name:String, location:String, description:String, imgUrl:String, recommender:String) -> Post{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let post = Post(context: context)
        post.placeName = name
        post.location = location
        post.descriptionPlace = description
        post.imageUrl = imgUrl
        post.recommenderId = recommender
        
        return post
    }
    
    
    
//    @NSManaged public var placeName: String?
//    @NSManaged public var location: String?
//    @NSManaged public var descriptionPlace: String?
//    @NSManaged public var imageUrl: String?
//    @NSManaged public var recommenderId: String?

}
