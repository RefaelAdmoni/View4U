//
//  DetailsPlaceViewController.swift
//  View4U
//
//  Created by admin on 14/07/2021.
//

import UIKit

class DetailsPlaceViewController: UIViewController {

    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var descriptionPlace: UITextView!
    @IBOutlet weak var locationPlace: UILabel!
    @IBOutlet weak var creator: UIButton!
    
    
    var placeEdite: String = ""{
        didSet{
            if (placeTitle != nil){
                placeTitle.text = placeEdite
            }
        }
    }
    var myImg:UIImage?{
        didSet{
            if (imagePlace != nil){
                imagePlace.image = myImg
            }
        }
    }
    var descriptionView: String = ""{
        didSet{
            if (descriptionPlace != nil) {
                descriptionPlace.text = descriptionView
            }
        }
    }
    var location: String = ""{
        didSet{
            if (locationPlace != nil){
                locationPlace.text = location
            }
        }
    }
    var creatorName: String = ""{
        didSet{
            if (creator != nil){
                creator.setTitle(creatorName, for: .normal)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        placeTitle.text = placeEdite
//        imagePlace.image = myImg
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
