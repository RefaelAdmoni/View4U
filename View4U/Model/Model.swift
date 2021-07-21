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
        users.append(user)
    }
    
    func delete(user:User){
        var i = 0
        for u in users{
            if u.id == user.id {
                users.remove(at: i)
                return
            }
            i = i+1
        }
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
        let context = (UIApplication.shared.delegate as! AppDelegate)
        posts.append(post)
    }
    
    func delete(post:Post){
        var i = 0
        for p in posts{
            if p.id == post.id {
                posts.remove(at: i)
                return
            }
            i = i+1
        }
    }
}
