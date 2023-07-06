//
//  FeedCell.swift
//  SnapChatClone
//
//  Created by mac on 7/5/23.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var feedUsernameLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
