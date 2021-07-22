//
//  RegisterViewController.swift
//  View4U
//
//  Created by admin on 06/07/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func register(_ sender: Any) {
        let user = User.create(name: userName.text!, email: userEmail.text!, imgUrl: "")
        user.name = userName.text
        user.email = userEmail.text
//        user.password = userPassword.text
        
        //add Image
        
        Model.instance.add(user: user)
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapView(_ sender: Any) {
        self.view.endEditing(true)
    }
}
