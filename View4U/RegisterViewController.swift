//
//  RegisterViewController.swift
//  View4U
//
//  Created by admin on 06/07/2021.
//

import UIKit

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var image: UIImage?
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func register(_ sender: Any) {
        if let image = image{
            Model.instance.saveImage(image: image, type:"USER") { (url) in
                self.saveNewUser(url: url)
            }
        }else{
            self.saveNewUser(url: "")
        }

    }
    
    func saveNewUser(url: String){
        let user = User.create(name: userName.text!, email: userEmail.text!, imgUrl: url)
        
        Model.instance.add(user: user){
            self.navigationController?.popViewController(animated: true)
        }
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

