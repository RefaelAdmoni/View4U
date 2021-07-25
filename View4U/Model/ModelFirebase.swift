//
//  ModelFirebase.swift
//  View4U
//
//  Created by admin on 22/07/2021.
//

import Foundation
import Firebase
import FirebaseFirestore
    
class ModelFirebase {
    init() {
        FirebaseApp.configure()
        
    }
    
    

//~~~~ Post ~~~//

    func getAllPosts(since:Int64, callback:@escaping ([Post])->Void) {
        let db = Firestore.firestore()
        db.collection("posts")
            .whereField("lastUpdated", isGreaterThan: Timestamp(seconds: since, nanoseconds: 0))
            .getDocuments { snapshot, error in
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
                sleep(5)
                callback(posts)
                return
            }
            }
            callback([Post]())
        }
    }
    
    func add(post:Post, callback:@escaping ()->Void){
        let db = Firestore.firestore()
        
        let docId =  db.collection("posts").document().documentID
        post.id = docId
        db.collection("posts").document(docId).setData(post.toJson()){
            //callback...
            err in
            if let err = err {
                print("Error writing document: \(err)")
            }else{
                print("Document successfully written in FB !")
            }
            callback()
        }
    }
    
    func update(post:Post, callback:@escaping ()->Void){
        let db = Firestore.firestore()
        
        let docId =  db.collection("posts").document(post.id!).documentID
        post.id = docId
        db.collection("posts").document(docId).setData(post.toJson()){
            //callback...
            err in
            if let err = err {
                print("Error writing document: \(err)")
            }else{
                print("Document successfully written in FB !")
            }
            callback()
        }
    }
    
    func delete(post:Post, callback:@escaping ()->Void){
        let db = Firestore.firestore()
        db.collection("posts").document(post.id!).delete() {
            err in if let err = err {
                print("Error writing document: \(err)")
            }else{
                print("Document successfully Deleted from Firebase!")
            }
        callback()
        }
    }
    
    func getPost(postId:String ,callback:@escaping (Post)->Void) {
        let db = Firestore.firestore()
        db.collection("posts").getDocuments { snapshot, error in
        if let err = error {
            print("Error reading document: \(err)")
        }else{
            if let snapshot = snapshot{
                var posts = [Post]()
                for snap in snapshot.documents{
                        if let p = Post.create(json:snap.data()){
                            if p.id == postId {
                                posts.append(p)
                            }
                        }
                    }
                callback(posts[0])
                return
            }
            }
            callback(Post())
        }
    }

    
    
    
//~~~~ User ~~~//
    
    func getAllUsers(callback:@escaping ([User])->Void) {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { snapshot, error in
        if let err = error {
            print("Error reading document: \(err)")
        }else{
            if let snapshot = snapshot{
                var users = [User]()
                for snap in snapshot.documents{
                    if let p = User.create(json:snap.data()){
                    users.append(p)
                    }
                }
                callback(users)
                return
            }
            }
            callback([User]())
        }
    }
    
    
    func add(user:User, callback:@escaping ()->Void){
        let db = Firestore.firestore()
        db.collection("users").document().setData(user.toJson()){
            //callback...
            err in
            if let err = err {
                print("Error writing document: \(err)")
            }else{
                print("Document successfully written!")
            }
         callback()
        }
    }
    
    func delete(user:User, callback:@escaping ()->Void){
        let db = Firestore.firestore()
        db.collection("users").document(user.id!).delete() {
            err in if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document SUCCESSFULLY removed ! ")
            }
        callback()
        }
    }
    
    func getUser(byId: String)->User?{
        
        return nil
    }
    
    static func saveImage(image:UIImage, type:String, callback:@escaping (String)->Void){
        var imageType = "gs://view4u-651d0.appspot.com/userPics"
        
        if type.elementsEqual("POST"){
            imageType = "gs://view4u-651d0.appspot.com/postsPics"
        }
        
        
        
        let storageRef = Storage.storage().reference(forURL: imageType)
        let data = image.jpegData(compressionQuality: 0.8)
        let imageRef = storageRef.child("imageName")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL{ (url, error) in
                guard let downloadURL = url else {
                    callback("")
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
    
}
