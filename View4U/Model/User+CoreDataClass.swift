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

    static func create(name:String, email:String, imgUrl:String) -> User{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User(context: context)
        user.name = name
        user.email = email
        user.imageUrl = imgUrl
        
        return user
    }

}
