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
import Firebase
import FirebaseFirestore

@objc(Post)
public class Post: NSManagedObject {

    static func create(name:String, location:String, description:String, imageUrl:String, recommender:String, lastUpdated:Int64 = 0) -> Post{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let post = Post(context: context)
        post.placeName = name
        post.location = location
        post.descriptionPlace = description
        post.imageUrl = imageUrl
        post.lastUpdated = lastUpdated
        post.recommenderId = recommender

        post.isDeletedFlag = false
        
        
        return post
    }
    
    static func create(json:[String:Any]) -> Post?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let post = Post(context: context)
        
        post.id = json["id"] as? String
        post.placeName = json["placeName"] as? String
        post.location = json["location"] as? String
        post.descriptionPlace = json["descriptionPlace"] as? String
        post.imageUrl = json["imageUrl"] as? String
        post.recommenderId = json["recommenderId"] as? String
//        post.lastUpdated = 0
        if let timestamp = json["lastUpdated"] as? Timestamp {
            post.lastUpdated = timestamp.seconds
        }

        post.isDeletedFlag = false
        if let df = json["isDeletedFlag"] as? Bool {
            post.isDeletedFlag = df
        }
        
        return post
    }
    
    func toJson()->[String:Any]{
        var json = [String:Any]()
        json["placeName"] = placeName!
        json["location"] = location!
        json["descriptionPlace"] = descriptionPlace!
//        json["date"] = date!
        json["recommenderId"] = recommenderId!
        json["id"] = id!
        if let imageUrl = imageUrl{
            json["imageUrl"] = imageUrl
        }else{
            json["imageUrl"] = ""
        }
        json["lastUpdated"] = FieldValue.serverTimestamp()
        json["isDeletedFlag"] = isDeletedFlag
        
        return json
    }
}
 

extension Post{
    
    static func getAll(callback:@escaping ([Post])->Void) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Post.fetchRequest() as NSFetchRequest<Post>
        
        request.predicate = NSPredicate(format: "isDeletedFlag == false")
        request.sortDescriptors = [NSSortDescriptor(key: "lastUpdated",ascending: false)]
        
        DispatchQueue.global().async {
            //second thread code
            var data = [Post]()
            do{
                data = try context.fetch(request)
            } catch {  }
            
            DispatchQueue.main.async {
                //code to execute on main thread
                callback(data)
            }
        }
    }
    
    static func getAllByUser(email:String, callback:@escaping ([Post])->Void) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Post.fetchRequest() as NSFetchRequest<Post>
        request.predicate = NSPredicate(format: "isDeletedFlag == false")
        request.sortDescriptors = [NSSortDescriptor(key: "lastUpdated",ascending: false)]
        
        DispatchQueue.global().async {
            //second thread code
            var data = [Post]()
            do{
                data = try context.fetch(request)
            } catch {  }
            
            DispatchQueue.main.async {
                //code to execute on main thread
                callback(data)
            }
        }
    }
        
        
    func save(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do{
            try context.save()
        }catch{    }
    }
    
    func delete(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(self)
        do{
            try context.save()
        }catch{    }
    }
    
    static func getPost(byId: String)->Post?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = Post.fetchRequest() as NSFetchRequest<Post>
        request.predicate = NSPredicate(format: "id == \(byId)")
        do{
            let posts = try context.fetch(request)
            if posts.count > 0 {
                return posts[0]
            }
        }catch{    }
        
        return nil
    }
    
    
    static func setLocalLastUpdate(_ localLastUpdate:Int64){
        UserDefaults.standard.setValue(localLastUpdate, forKey: "PostsLastUpdateDate")
    }
    static func getLocalLastUpdate()->Int64{
        return Int64(UserDefaults.standard.integer(forKey: "PostsLastUpdateDate"))
    }
    
    
}
