//
//  RegisterViewController.swift
//  View4U
//
//  Created by admin on 06/07/2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var image: UIImage?
    
    @IBOutlet weak var spinerActivity: UIActivityIndicatorView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
      
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func register(_ sender: Any) {
        if (userName.text!.count <= 0){
            print("Must enter a user name")
            self.errorLabel.text = "Must enter a user name"
            return
        }
        if (userEmail.text!.count <= 0){
            print("Must enter a user email")
            self.errorLabel.text = "Must enter a user email"
            return
        }
        if (userPassword.text!.count <= 7){
            print("Must enter more then 7 character in password")
            self.errorLabel.text = "Must enter more then 7 character in password"
            return
        }
        
        self.errorLabel.text = ""
        self.spinerActivity.startAnimating()
        if let image = image{
            Model.instance.saveImage(image: image, type:"USER") { (url) in
                self.saveNewUser(url: url)
            }
        }else{
            self.saveNewUser(url: "")
        }

    }
    
    func saveNewUser(url: String){
        
        Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { (result, err) in
            
            //check for errors
            if err != nil {
                //there was an error creating the user
                print("Error creating user ! ")
                self.errorLabel.text = "Error creating user ! "
                self.spinerActivity.stopAnimating()
            }else {
                //User was created successfully...
                let user = User.create(name: self.userName.text!, email: self.userEmail.text!, imageUrl: url, id:result!.user.uid)
//                let user = User()
//                user.email = userEmail.text!
//                user.imageUrl = url
//                user.name = self.userName.text!
//                user.id = result!.user.uid
                Model.instance.create(user: user){
                    self.spinerActivity.stopAnimating()
                    sleep(3)
                    self.transitionToHomePage()
//                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            
        }
        
        
//        let user = User.create(name: userName.text!, email: userEmail.text!, imgUrl: url)
//
//        Model.instance.create(user: user, password: userPassword.text!){
//            self.spinerActivity.stopAnimating()
//            sleep(3)
//            self.dismiss(animated: true, completion: nil)
//        }
  
    }
    
    func transitionToHomePage(){
        self.dismiss(animated: true, completion: nil)
        
//        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeVC") as? PostsListViewController
//
//        view.window?.rootViewController = homeViewController
//        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapView(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func editPic(_ sender: Any) {
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
}

