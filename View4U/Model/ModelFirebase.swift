//
//  ModelFirebase.swift
//  View4U
//
//  Created by admin on 22/07/2021.
//

import Foundation
import Firebase
    
class ModelFirebase {
    init() {
        FirebaseApp.configure()
        
    }
    
    func getAllPosts(callback:@escaping ([Post])->Void) {
        let db = Firestore.firestore()
        db.collection("posts").getDocuments { snapshot, error in
        if let err = error {
            print("Error reading document: \(err)")
        }else{
            if let snapshot = snapshot{
                var posts = [Post]()
                for snap in snapshot.documents{
                    if let p = Post.create(json:snap.data()){
                    posts.append(p)
                    }
                }
                callback(posts)
                return
            }
            }
            callback([Post]())
        }
    }
    
    
    func add(post:Post){
        let db = Firestore.firestore()
        db.collection("posts").document().setData(post.toJson()){
            //callback...
            err in
            if let err = err {
                print("Error writing document: \(err)")
            }else{
                print("Document successfully written!")
            }
        }
    }
    
    func delete(post:Post){

    }
    
    func getPost(byName: String)->Post?{
        
        return nil
    }
}
