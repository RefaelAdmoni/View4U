//
//  User+CoreDataClass.swift
//  View4U
//
//  Created by admin on 21/07/2021.
//
//

import Foundation
import UIKit
import CoreData

@objc(User)
public class User: NSManagedObject {

    static func create(name:String, email:String, imageUrl:String) -> User{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User(context: context)
        user.name = name
        user.email = email
        user.imageUrl = imageUrl
        
        return user
    }
    static func create(name:String, email:String, imageUrl:String, id:String) -> User{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User(context: context)
        user.name = name
        user.email = email
        user.imageUrl = imageUrl
        user.id = id
        
        return user
    }
    
    static func create(json:[String:Any]) -> User?{
        let user = User()
        user.name = json["name"] as? String
        user.email = json["email"] as? String
        user.imageUrl = json["imageUrl"] as? String
        user.id = json["id"] as? String
        
        return user
    }
    
    func toJson()->[String:Any]{
        var json = [String:Any]()

        json["name"] = name!
        json["email"] = email!
        json["id"] = id!
        if let imageUrl = imageUrl{
            json["imageUrl"] = imageUrl
        }else{
            json["imageUrl"] = ""
        }
        
        return json
    }
}


extension User{
    func createUser(name: String, email: String, imageUrl: String, id:String)->User{
        
        let user = User()
        user.name = name
        user.email = email
        user.imageUrl = imageUrl
        user.id = id
        
        return user
    }
}
