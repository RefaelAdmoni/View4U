//
//  PostsListViewController.swift
//  View4U
//
//  Created by admin on 06/07/2021.
//

import UIKit

class PostsListViewController: UIViewController, UITableViewDelegate /*, MyCustomSegueSourceDelegate*/ {
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolBar.setRightBarButtonItems([signinBtn], animated: true)
        toolBar.setLeftBarButtonItems([addReco], animated: true)
    }
    
    //this func works when this view is show up. (always!)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postData = Model.instance.getAllPosts()
//        userData = Model.instance.getAllUsers()
        
        //update data
        tableView.reloadData()
        
        
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
        
        cell.locationTitleLebal.text = post.placeName
//        cell.textView.text = post.description
//        cell.postImg. = post.imageUrl
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
        print(cell.postImg.image ?? "sea")
        print("....********....")
        
        
        nextVC.placeEdite = cell.locationTitleLebal.text!;
        nextVC.myImg = cell.postImg.image
//        nextVC.descriptionView = cell.textView.text!
        nextVC.location = "Somewhere..."
        nextVC.creatorName = "Rafii"

        

        
        
        
        
    }
    
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
}

//protocol MyCustomSegueSourceDelegate {
//    func getViewContainer(forIndentifier:String)->UIView
//}
//
//
//class MyCustomSegue: UIStoryboardSegue {
//    override func perform() {
//        source.addChild(destination)
//        let parent = source as! MyCustomSegueSourceDelegate
//
//        let container = parent.getViewContainer(forIndentifier: identifier ?? "")
//        destination.view.frame = container.frame
//
//        destination.view.frame.origin = CGPoint(x: 10, y: 10)
//        container.addSubview(destination.view)
//
//
//    }
//}
