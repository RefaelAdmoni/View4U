//
//  Model.swift
//  View4U
//
//  Created by admin on 17/07/2021.
//

import Foundation

class Model{
    static let instance = Model()
    
    private init(){}
    var users = [User]()
    var posts = [Post]()
    
    //user..
    func getAllUsers()->[User]{
        return users
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
        return posts
    }
    
    func add(post:Post){
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
