//
//  UserProfileViewController.swift
//  View4U
//
//  Created by admin on 07/07/2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import Kingfisher

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var user = User()
    
    //getting the storyboard
    let sb = UIStoryboard(name:"Main", bundle: nil)
    
    var image: UIImage?
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveUpdateBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var editFlag:Bool = false
    var postsData = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveUpdateBtn.isHidden = true
        // Do any additional setup after loading the view.
        self.reloadData()
        self.getUserDetails()
        
        tableView.addSubview(refreshControl)
        
        //catching slide down by user.
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        reloadData()
        
        //Listener to notify
        Model.instance.notificationPostList.observe {
            self.reloadData()
        }
        
    }
    @objc func refresh(_ sender:AnyObject){
        self.reloadData()
    }
    
    
    
    func getUserDetails(){
        let db = Firestore.firestore()
        var user = User()
        
        let handle = Auth.auth().addStateDidChangeListener{ auth, user in
            
            let db = Firestore.firestore()
            db.collection("users")
                .whereField("id", isGreaterThan: user?.uid ?? "")
                .getDocuments { snapshot, error in
            if let err = error {
                print("Error reading document: \(err)")
            }else{
                if let snapshot = snapshot{
                    var users = [User]()
                    for snap in snapshot.documents{
                        if let u = User.create(json:snap.data()){
                        users.append(u)
                            self.nameOutlet.text = u.name!
                            self.emailOutlet.text = u.email!
                        }
                    }
                }
                }
            }
    }
    }
    
    @IBAction func editMyPostsMode(_ sender: Any) {
        self.editFlag = true;
        
    }
    
    func reloadData() {
        refreshControl.beginRefreshing()
        Model.instance.getAllPostsForCurrentUser(email: emailOutlet.text!){
            posts in self.postsData = posts
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        
        }
    }
    
    
    
    @IBAction func backToTheList(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveUpdateUser(_ sender: Any) {
        updateUser()
        saveUpdateBtn.isHidden = true
        self.saveUpdateBtn.isEnabled = false
    }
    
    func updateUser(){
        if let image = image{
            Model.instance.saveImage(image: image, type:"USER") { (url) in
                self.user.imageUrl = url
//                Model.instance.add(user: self.user){
//
//                }
            }
        }else{ }
    }
    
    
    @IBAction func editPicture(_ sender: Any) {
        saveUpdateBtn.isHidden = false
        self.saveUpdateBtn.isEnabled = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addReview(_ sender: Any) {
        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "AddReviewViewController") as! AddReviewViewController
        
        present(nextVC, animated: true, completion: nil)
        
        
    }
}


extension UserProfileViewController: UITableViewDataSource{
    
    /*UITableViewDelegate protocol */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPostsListRow", for: indexPath) as! PostsTableViewCell
        
        let post = postsData[indexPath.row]
        
        cell.post = post
        
        cell.locationTitleLebal.text = post.placeName

//        cell.setImgUrl(url: post.imageUrl!)
        if ((post.imageUrl) != nil){
            cell.imageView?.kf.setImage(with: URL(string:post.imageUrl!))
        }
        cell.location.text = post.location
        cell.recommender.text = post.recommenderId
//        cell.publishedDate.text = post.lastUpdated
        

        return cell
    }
    
    
    /* table view degate */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("The cell \(indexPath) was selected! \n")
        
        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "DetailsPlaceViewController") as! DetailsPlaceViewController

        let cell = tableView.cellForRow(at: indexPath) as! PostsTableViewCell

        present(nextVC, animated: true, completion: nil)
        
        
        print("....********....")

        print("....********....")
        
        
        nextVC.placeEdite = cell.locationTitleLebal.text!;
        nextVC.myImg = cell.post.imageUrl ?? ""
        nextVC.descriptionView.removeAll()
        nextVC.descriptionView = cell.post.descriptionPlace!
        nextVC.location = cell.location.text!
        nextVC.creatorName = cell.post.recommenderId!

        
    }
}
    
extension UserProfileViewController: UITableViewDelegate{
    
    /*Checked to editing row in tableView */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.editFlag
    }
    
    /*func - delete the choosen row by the user */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = postsData[indexPath.row]
            Model.instance.delete(post: post){
                self.postsData.remove(at: indexPath.row)
                //Delete the row from the database
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            //Create a new instance of the appropriate class, insert it into the arry, and add a new row to the table view
            
        }
    }
}

