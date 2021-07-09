//
//  PostsTableViewCell.swift
//  View4U
//
//  Created by admin on 09/07/2021.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var locationName_OutletBtn: UIButton!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    
    @IBAction func locationName_btn(_ sender: Any) {
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
