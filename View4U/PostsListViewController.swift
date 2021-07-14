//
//  PostsListViewController.swift
//  View4U
//
//  Created by admin on 06/07/2021.
//

import UIKit

class PostsListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate /*, MyCustomSegueSourceDelegate*/ {
    @IBOutlet weak var postsTableView: UITableView!
        

    var data = [1,2,3,4,5,6,7,8,9]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
    }
    
    
    
    var editingFlag = false
    @IBAction func trashAction(_ sender: Any) {
        editingFlag = !editingFlag
        postsTableView.setEditing(editingFlag, animated: true)
    }
    
    
    
    /*UITableViewDelegate protocol */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "postsListRow", for: indexPath) as! PostsTableViewCell
        
        cell.locationTitleLebal.text = "location view no. " + String(indexPath.row)
        cell.textView.insertText("Description text will be here...")
        cell.textView.setMarkedText("Description text will write HERE ! ", selectedRange: .init())
        
        return cell
    }
    
    
    /* table view degate */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("The cell \(indexPath) was selected! \n")
        
        //getting the storyboard
        let sb = UIStoryboard(name:"Main", bundle: nil)
        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "DetailsPlaceViewController") as! DetailsPlaceViewController

        let cell = tableView.cellForRow(at: indexPath) as! PostsTableViewCell

        
        present(nextVC, animated: true, completion: nil)
        
        
        print("....********....")
        print(cell.postImg.image ?? "sea")
        print("....********....")
        
        
        nextVC.placeEdite = cell.locationTitleLebal.text!;
        nextVC.myImg = cell.postImg.image
        nextVC.descriptionView = cell.textView.text!
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
            data.remove(at: indexPath[1])
            //Delete the row from the database
            postsTableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //Create a new instance of the appropriate class, insert it into the arry, and add a new row to the table view
            
        }
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
