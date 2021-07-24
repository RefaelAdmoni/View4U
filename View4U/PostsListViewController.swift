//
//  PostsListViewController.swift
//  View4U
//
//  Created by admin on 06/07/2021.
//

import UIKit

class PostsListViewController: UIViewController {
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    //getting the storyboard
    let sb = UIStoryboard(name:"Main", bundle: nil)

    @IBOutlet weak var trash: UIBarButtonItem!
    @IBOutlet weak var toolBar: UINavigationItem!
    @IBOutlet weak var signinBtn: UIBarButtonItem!
    @IBOutlet weak var profileBtn: UIBarButtonItem!
    @IBOutlet weak var addReco: UIBarButtonItem!
    
    
    var postData = [Post]()
    var userData = [User] ()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolBar.setRightBarButtonItems([signinBtn, profileBtn], animated: true)
        toolBar.setLeftBarButtonItems([addReco, trash], animated: true)
        
        //getiing all posts
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
        

//        userData = Model.instance.getAllUsers()
        
        //update data
//        tableView.reloadData()
        
        
    }
    
    
    var editingFlag = false
    @IBAction func trashAction(_ sender: Any) {
        editingFlag = !editingFlag
        postsTableView.setEditing(editingFlag, animated: true)
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
        
        let post = postData[indexPath.row]
        
        cell.post = post
        
        cell.locationTitleLebal.text = post.placeName

//        cell.postImg = post.imageUrl
        cell.location.text = post.location
        cell.recommender.text = post.recommenderId
        cell.publishedDate.text = stringFromDate(post.date ?? Date() )
        
        print(stringFromDate(post.date ?? Date()))
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
        print(cell.postImg.image ?? "sea")
        print("....********....")
        
        
        nextVC.placeEdite = cell.locationTitleLebal.text!;
        nextVC.myImg = cell.postImg.image
        nextVC.descriptionView.removeAll()
        nextVC.descriptionView = cell.post.descriptionPlace!
        nextVC.location = cell.location.text!
        nextVC.creatorName = "Rafii"

        
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
            Model.instance.delete(post: post)
            postData.remove(at: indexPath.row)
            
            //Delete the row from the database
            postsTableView.deleteRows(at: [indexPath], with: .fade)
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

        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "LoginViewController")
//        //create the new window - get optional object
//        let win = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
//        win?.rootViewController = nextVC
//
        present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func goToMyProfile(_ sender: Any) {
        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "UserProfileViewController")
        
        present(nextVC, animated: true, completion: nil)
    }
        
        
        func stringFromDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy HH:mm"
            return formatter.string(from: date)
        }
}
