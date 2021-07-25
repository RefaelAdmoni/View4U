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
    
    static func create(json:[String:Any]) -> User?{
        let user = User()
        user.name = json["name"] as? String
        user.email = json["email"] as? String
        user.imageUrl = json["imgUrl"] as? String
        
        return user
    }
    
    func toJson()->[String:Any]{
        var json = [String:Any]()

        json["name"] = name!
        json["email"] = email!
        
        if let imageUrl = imageUrl{
            json["imageUrl"] = imageUrl
        }else{
            json["imageUrl"] = ""
        }
        
        return json
    }
}


extension User{
    func createUser(password:String){
        Model.instance.create(user:self, password:password){
            
        }
        
    }
    
//    static func getAll()->[User]{
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do{
//            let users = try context.fetch(User.fetchRequest()) as! [User]
//
//            return users
//
//        } catch {    return [User]()    }
//    }
    
//    func save(){
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do{
//            try context.save()
//        }catch{    }
//    }
    
//    func delete(){
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        context.delete(self)
//        do{
//            try context.save()
//        }catch{    }
//        
//    }
    
    
    static func getUser(byName: String)->User?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = User.fetchRequest() as NSFetchRequest<User>
        request.predicate = NSPredicate(format: "name == \(byName)")
        do{
            let users = try context.fetch(request)
            if users.count > 0 {
                return users[0]
            }
        }catch{    }
        
        return nil
    }
}
