//
//  AddReviewViewController.swift
//  View4U
//
//  Created by admin on 14/07/2021.
//

import UIKit

class AddReviewViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

  
    @IBOutlet weak var spinerActivity: UIActivityIndicatorView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    //TODO: add recommender
    
    var refreshControl = UIRefreshControl()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func save(_ sender: Any) {
        if let image = image{
            Model.instance.saveImage(image: image, type:"POST") { (url) in
                self.savePost(url: url)
            }
        }else{
            self.savePost(url: "")
        }
        
    }
    
    func savePost(url: String){
        self.spinerActivity.startAnimating()
        let post = Post.create(name: placeName.text!, location: location.text!, description: desc.text!, imgUrl: url, recommender: "Rafiii...")

        Model.instance.add(post: post){
            self.spinerActivity.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func onTapView(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func editImage(_ sender: Any) {
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
