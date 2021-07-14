//
//  PostsTableViewCell.swift
//  View4U
//
//  Created by admin on 09/07/2021.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var locationTitleLebal: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
