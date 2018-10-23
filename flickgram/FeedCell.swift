//
//  FeedCell.swift
//  flickgram
//
//  Created by Bhavesh Shah on 10/22/18.
//  Copyright © 2018 Bhavesh Shah. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
