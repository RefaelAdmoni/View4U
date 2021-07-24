//
//  UserProfileViewController.swift
//  View4U
//
//  Created by admin on 07/07/2021.
//

import UIKit

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var user = User()
    
    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveUpdateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backToTheList(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveUpdateUser(_ sender: Any) {
        updateUser()
        self.saveUpdateBtn.isEnabled = false
    }
    
    func updateUser(){
        if let image = image{
            Model.instance.saveImage(image: image, type:"USER") { (url) in
                self.user.imageUrl = url
                Model.instance.add(user: self.user){
                    
                }
            }
        }else{
            
        }
    }
    
    
    @IBAction func editPicture(_ sender: Any) {
        self.saveUpdateBtn.isEnabled = true
        
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
