//
//  PostsTableViewCell.swift
//  View4U
//
//  Created by admin on 09/07/2021.
//

import UIKit
import Kingfisher

class PostsTableViewCell: UITableViewCell {

    var post = Post()
    
    @IBOutlet weak var locationTitleLebal: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var recommender: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var picContainer: UIScrollView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func setImgUrl(url:String){
        var myImage:UIImageView = UIImageView()
//        postImg.kf.setImage(with: URL(string: url))
        
        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        func downloadImage(from url: URL) {
            print("Download Started")
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.async() {
                    myImage.image = UIImage(data: data)
                    self.postImg.image = myImage.image
                }
            }
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
