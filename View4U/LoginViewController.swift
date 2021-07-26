//
//  LoginViewController.swift
//  View4U
//
//  Created by admin on 04/07/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var spinerActivity: UIActivityIndicatorView!
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passwordUser: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    



    @IBAction func ClickedForRegister(_ sender: Any) {
     performSegue(withIdentifier: "toRegisterView", sender: self)
        
        
        
        
//        //getting the storyboard
//        let sb = UIStoryboard(name:"Main", bundle: nil)
//        //get the next View Controller from the storyboard
//        let nextVC = sb.instantiateViewController(identifier: "RegisterViewController")
////        //create the new window - get optional object
////        let win = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
////        win?.rootViewController = nextVC
////
//        present(nextVC, animated: true, completion: nil)
//
        
    }
    
    
    @IBAction func Login(_ sender: Any) {
        
        if (emailUser.text!.count <= 0){
            print("Must enter a user email")
            self.errorLabel.text = "Must enter a user email"
            return
        }
        if (passwordUser.text!.count <= 0){
            print("Must enter a user password")
            self.errorLabel.text = "Must enter a user password"
            return
        }
        errorLabel.text = ""
        self.spinerActivity.startAnimating()
        
        let email = emailUser.text!
        let password = passwordUser.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //couldn't sign in
                self.errorLabel.text = " Cannot sign in ! "
                self.spinerActivity.stopAnimating()
            }
            else{
                print("you're signed in ! ")
                self.dismiss(animated: true, completion: nil)

//                let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomePageVC") as? PostsListViewController
//
//                self.view.window?.rootViewController = homeViewController
//                self.view.window?.makeKeyAndVisible()
            }
        }
        
        
        
        
        
        
//        Model.instance.signin(email: email, password: password){
//
//
//            self.spinerActivity.stopAnimating()
//
//
//
//            sleep(3)
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTapView(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}
