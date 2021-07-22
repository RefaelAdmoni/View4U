//
//  Model.swift
//  View4U
//
//  Created by admin on 17/07/2021.
//

import Foundation
import UIKit

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
    
    
    
    // post..
    func getAllPosts()->[Post]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let posts = try context.fetch(Post.fetchRequest()) as! [Post]
            
            return posts
       
        } catch {    return [Post]()    }
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
}
