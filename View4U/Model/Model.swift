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
   
    //user..
    func getAllUsers(callback:@escaping ([User])->Void){

    }
    
    func add(user:User){

    }
    
    func delete(user:User){
        
    }
    
    func getUser(byName: String)->User?{
        
        return nil
    }
    
    
    // post..
    func getAllPosts(callback:@escaping ([Post])->Void) {

    }
    
    
    func add(post:Post){

    }
    
    func delete(post:Post){

    }
    
    func getPost(byName: String)->Post?{
        
        return nil
    }
}
