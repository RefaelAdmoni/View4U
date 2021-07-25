//
//  Model.swift
//  View4U
//
//  Created by admin on 17/07/2021.
//

import Foundation
import UIKit
import CoreData

class NotificationGeneral{
    let name: String
    init (_ name: String) {
        self.name = name
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(name), object: self)
    }
    
    func observe(callback:@escaping ()->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(name), object: nil, queue: nil) {
            (notification) in callback()
        }
    }
}

class Model{
    static let instance = Model()
    
    private init(){}
    
    public let notificationPostList = NotificationGeneral("notificationPostList")
    public let notificationLogin = NotificationGeneral("notificationLogin")
    let modelFirebase = ModelFirebase()
    
    
//~~~~ user ~~~~
    
    func create(user:User, password:String, callback:@escaping ()->Void){
        modelFirebase.create(user:user, password:password){
            //notify the post list data change
        }
    }
    func signin(email:String, password:String, callback:@escaping ()->Void){
        modelFirebase.signin(email:email, password:password, callback:callback)
    }
    
    func signout(user:User){
//        modelFirebase.delete(user: user){
            //notify the post list data change
            self.notificationPostList.post()
        
    }
    
    func getUser(byId: String)->User?{
        return modelFirebase.getUser(byId: byId)
    }
    
    

    
    
    
    // post..
    func getAllPosts(callback:@escaping ([Post])->Void) {
        //get the local update date
        var localLastUpdate = Post.getLocalLastUpdate()
        
        //get updates from firebase
        modelFirebase.getAllPosts(since: localLastUpdate){ (posts) in

            
            //update the local last update date
            for p in posts{
                print("post last updated = \(p.lastUpdated)")
                if (p.lastUpdated > localLastUpdate){
                    localLastUpdate = p.lastUpdated
                }
            }
            Post.setLocalLastUpdate(localLastUpdate)
            
            //remove deleted
            for p in posts {
                if p.isDeletedFlag {
                    p.delete()
                }
            }
            
            //update the local DB
            if(posts.count > 0){
                posts[0].save()
            }
            
            //read all posts from local DB
            //retrun the list to the caller
            Post.getAll(callback: callback)
        }
    }
    
    func add(post:Post, callback:@escaping ()->Void){
        modelFirebase.add(post: post, callback: callback)
        self.notificationPostList.post()
    }
    
    func delete(post:Post, callback:@escaping ()->Void){
        post.isDeletedFlag = true
        modelFirebase.update(post: post){
            self.modelFirebase.delete(post: post, callback: callback)
        }
    }
    
    func getPost(byId: String, callback:@escaping (Post)->Void){
        modelFirebase.getPost(postId: byId, callback: callback)
    }
    
    
    
    
    
    
    
    //~~~~~~ IMAGE FUNCS ~~~~~//
    func saveImage(image:UIImage, type:String, callback:@escaping (String)->Void){
        ModelFirebase.saveImage(image: image, type: type, callback: callback)
    }
    

    
}
