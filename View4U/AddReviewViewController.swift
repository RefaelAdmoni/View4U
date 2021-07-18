//
//  AddReviewViewController.swift
//  View4U
//
//  Created by admin on 14/07/2021.
//

import UIKit

class AddReviewViewController: UIViewController {

  
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var location: UITextField!
    //TODO: add recommender
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func save(_ sender: Any) {
        let post = Post()
        post.placeName = placeName.text
        post.description = desc.text!
        post.location = location.text
//        post.recommenderId = Rafi
        
        Model.instance.add(post: post)
//        navigationController?.popViewController(animated: true) //pop out this view.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func onTapView(_ sender: Any) {
        self.view.endEditing(true)
    }
}
