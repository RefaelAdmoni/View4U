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
    
    
    //user..
    func getAllUsers(callback:@escaping ([User])->Void){
        modelFirebase.getAllUsers(callback: callback)
    }
    
    func add(user:User, callback:@escaping ()->Void){
        modelFirebase.add(user: user){
            //notify the post list data change
            self.notificationPostList.post()
        }
    }
    
    func delete(user:User){
        modelFirebase.delete(user: user){
            //notify the post list data change
            self.notificationPostList.post()
        }
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
            
        }
        
        //update the local DB
        
        //update the local last update date
        
        //read all posts from local DB
        //retrun the list to the caller
        
        
    }
    
    func add(post:Post, callback:@escaping ()->Void){
        modelFirebase.add(post: post){
            //notify the post list data change
        callback()
        self.notificationPostList.post()
        }
    }
    
    func delete(post:Post){
        modelFirebase.delete(post: post){
            //notify the post list data change
            sleep(5)
            self.notificationPostList.post()
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
