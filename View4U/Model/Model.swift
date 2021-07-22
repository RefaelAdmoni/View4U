//
//  Model.swift
//  View4U
//
//  Created by admin on 17/07/2021.
//

import Foundation
import UIKit
import CoreData

class Model{
    static let instance = Model()
    
    private init(){}
    var users = [User]()
    var posts = [Post]()

   
    //user..
    func getAllUsers()->[User]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let users = try context.fetch(User.fetchRequest()) as! [User]
            
            return users
       
        } catch {    return [User]()    }
    }
    
    func add(user:User){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try context.save()
        }catch{    }
    }
    
    func delete(user:User){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(user)
        do{
            try context.save()
        }catch{    }
        
    }
    
    
    func getUser(byName: String)->User?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = User.fetchRequest() as NSFetchRequest<User>
        request.predicate = NSPredicate(format: "name == \(byName)")
        do{
            let users = try context.fetch(request)
            if users.count > 0 {
                return users[0]
            }
        }catch{    }
        
        return User()
    }
    
    
    // post..
    func getAllPosts(callback:@escaping ([Post])->Void) {
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
    
    
    func add(post:Post){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try context.save()
        }catch{    }
    }
    
    func delete(post:Post){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(post)
        do{
            try context.save()
        }catch{    }
    }
    
    func getPost(byName: String)->Post?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = Post.fetchRequest() as NSFetchRequest<Post>
        request.predicate = NSPredicate(format: "name == \(byName)")
        do{
            let posts = try context.fetch(request)
            if posts.count > 0 {
                return posts[0]
            }
        }catch{    }
        
        return Post()
    }
}
