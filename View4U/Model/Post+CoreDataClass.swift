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
        post.date = Date()
        
        
        return post
    }
    
    static func create(json:[String:Any]) -> Post?{
        return nil
    }
    
    func toJson()->[String:Any]{
        var json = [String:Any]()
        json["placeName"] = placeName!
        json["location"] = location!
        json["descriptionPlace"] = descriptionPlace!
        json["date"] = date!
        json["recommenderId"] = recommenderId!
        if let imageUrl = imageUrl{
            json["imageUrl"] = imageUrl
        }else{
            json["imageUrl"] = ""
        }
        
        return json
    }
}
 

extension Post{
    
    static func getAll(callback:@escaping ([Post])->Void) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Post.fetchRequest() as NSFetchRequest<Post>
        
        request.sortDescriptors = [NSSortDescriptor(key: "date",ascending: false)]
        
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
    
    static func getPost(byName: String)->Post?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = Post.fetchRequest() as NSFetchRequest<Post>
        request.predicate = NSPredicate(format: "name == \(byName)")
        do{
            let posts = try context.fetch(request)
            if posts.count > 0 {
                return posts[0]
            }
        }catch{    }
        
        return nil
    }
}
