//
//  AskQuestionHeaderCell.swift
//  QASampleApp
//
//  Created by krishnika agarwal on 18/12/16.
//  Copyright © 2016 krishnika agarwal. All rights reserved.
//

import UIKit

class AskQuestionHeaderCell: UITableViewCell {

    @IBOutlet weak var askNowButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        askNowButton.layer.cornerRadius = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
