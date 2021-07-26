//
//  PostsListViewController.swift
//  View4U
//
//  Created by admin on 06/07/2021.
//

import UIKit
import Firebase
import Kingfisher

class PostsListViewController: UIViewController {
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinerActivity: UIActivityIndicatorView!
    
    //getting the storyboard
    let sb = UIStoryboard(name:"Main", bundle: nil)

    @IBOutlet weak var trash: UIBarButtonItem!
    @IBOutlet weak var toolbar: UINavigationItem!
    @IBOutlet weak var signoutBtn: UIBarButtonItem!
    @IBOutlet weak var signinBtn: UIBarButtonItem!
    @IBOutlet weak var profileBtn: UIBarButtonItem!
    @IBOutlet weak var addReco: UIBarButtonItem!
    
    
    
    var postData = [Post]()
    var userData = [User] ()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getiing all posts
        tableView.addSubview(refreshControl)
        
        //catching slide down by user.
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        reloadData()
        
        //Listener to notify
        Model.instance.notificationPostList.observe {
            self.reloadData()	
        }

        
//        btnBarController().self
    }
    @objc func refresh(_ sender:AnyObject){
        self.reloadData()
    }
    
    func reloadData() {
        refreshControl.beginRefreshing()
        Model.instance.getAllPosts{
            posts in self.postData = posts
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    //this func works when this view is show up. (always!)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.spinerActivity.startAnimating()
        reloadData()
        
        
        self.toolbar.setRightBarButtonItems([signoutBtn,profileBtn,signinBtn], animated: true)
        self.toolbar.setLeftBarButtonItems([addReco,trash], animated: true)
        btnBarController()
        
        self.spinerActivity.stopAnimating()
    }
    
    
    var editingFlag = false
    @IBAction func trashAction(_ sender: Any) {
        editingFlag = !editingFlag
        postsTableView.setEditing(editingFlag, animated: true)
    }
    
    @IBAction func signout(_ sender: Any) {
        signoutBtn.isSpringLoaded = true
        self.spinerActivity.startAnimating()
        do{
            if Auth.auth().currentUser != nil{
                
                try Auth.auth().signOut()
                sleep(3)
//                toolbar.setRightBarButtonItems([], animated: true)
//                toolbar.setLeftBarButtonItems([], animated: true)

                print("the user signed out successfully ! ")
            }} catch{
            print("An error to sign the user out... ")
        }
//        viewWillAppear(true)
        btnBarController()
        signoutBtn.isSpringLoaded = false
        self.spinerActivity.stopAnimating()
    }
    
    func btnBarController(){
        if Auth.auth().currentUser != nil {
            
            //The user signed in
            if ((signoutBtn) != nil){self.signoutBtn.tintColor = .brown}
            if ((profileBtn) != nil){self.profileBtn.tintColor = .brown}
            if ((addReco) != nil){self.addReco.tintColor = .brown}
            if ((trash) != nil){self.trash.tintColor = .brown}
            if ((signinBtn) != nil){self.signinBtn.tintColor = .clear}
            
//            self.toolbar.setRightBarButtonItems([signoutBtn,profileBtn], animated: true)
//            self.toolbar.setLeftBarButtonItems([addReco,trash], animated: true)
        }else {
            //the user was not signed in
            if ((signoutBtn) != nil){self.signoutBtn.tintColor = .clear}
            if ((profileBtn) != nil){self.profileBtn.tintColor = .clear}
            if ((addReco) != nil){self.addReco.tintColor = .clear}
            if ((trash) != nil){self.trash.tintColor = .clear}
            if ((signinBtn) != nil){self.signinBtn.tintColor = .brown}
            

//            self.toolbar.setRightBarButton(signinBtn, animated: true)
//            self.toolbar.setLeftBarButtonItems([], animated: true)
        }
    }
    
}

extension PostsListViewController: UITableViewDataSource{
    
    /*UITableViewDelegate protocol */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "postsListRow", for: indexPath) as! PostsTableViewCell
        spinerActivity.startAnimating()
        let post = postData[indexPath.row]
        
        cell.post = post
        
        cell.locationTitleLebal.text = post.placeName
        
        cell.setImgUrl(url: post.imageUrl!)
//        if ((post.imageUrl) != nil){
//            cell.imageView?.kf.setImage(with: URL(string:post.imageUrl!))
//        }
        spinerActivity.stopAnimating()
        cell.location.text = post.location
        cell.recommender.text = post.recommenderId

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
    
    extension PostsListViewController: UITableViewDelegate{
    
    /*Checked to editing row in tableView */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return editingFlag
    }
    
    /*func - delete the choosen row by the user */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = postData[indexPath.row]
            Model.instance.delete(post: post){
                self.postData.remove(at: indexPath.row)
                //Delete the row from the database
                self.postsTableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            //Create a new instance of the appropriate class, insert it into the arry, and add a new row to the table view
            
        }
    }
    
    
    @IBAction func goToAddReview(_ sender: Any) {
        
        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "AddReviewViewController") as! AddReviewViewController
        
        present(nextVC, animated: true, completion: nil)
        
    }
    
    @IBAction func goToSignIn(_ sender: Any) {
        self.spinerActivity.startAnimating()
        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "LoginViewController")

        present(nextVC, animated: true, completion: nil)
        self.spinerActivity.stopAnimating()
    }
    
    @IBAction func goToMyProfile(_ sender: Any) {
        self.spinerActivity.startAnimating()
        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "UserProfileViewController")
        
        present(nextVC, animated: true, completion: nil)
        self.spinerActivity.stopAnimating()
    }

}
