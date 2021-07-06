//
//  LoginViewController.swift
//  View4U
//
//  Created by admin on 04/07/2021.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



    @IBAction func ClickedForRegister(_ sender: Any) {
       //getting the storyboard
        let sb = UIStoryboard(name:"Main", bundle: nil)
        //get the next View Controller from the storyboard
        let nextVC = sb.instantiateViewController(identifier: "RegisterViewController")
//        //create the new window - get optional object
//        let win = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
//        win?.rootViewController = nextVC
//
        present(nextVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTapView(_ sender: Any) {
        self.view.endEditing(true)
    }
}
