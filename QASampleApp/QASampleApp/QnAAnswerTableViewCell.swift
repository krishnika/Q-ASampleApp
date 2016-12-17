//
//  QnAAnswerTableViewCell.swift
//  QASampleApp
//
//  Created by krishnika agarwal on 17/12/16.
//  Copyright © 2016 krishnika agarwal. All rights reserved.
//

import UIKit

class QnAAnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerCountLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        
        questionLabel.text = post.postBody ?? Utility.kNullConstant
        
        let answers = post.answers
        
        let answerCount = answers.count
        
        if answerCount > 0 {
            answerLabel.text = answers[0].answerBody ?? Utility.kNullConstant
            if let user = answers[0].user {
                userName.text = user.name ?? Utility.kNullConstant
                if let imageUrl = user.profilePic {
                    userImage.contentMode = UIViewContentMode.scaleAspectFit
                    
                }
                
            }
            
            if answerCount > 1 {
                answerCountLabel.text = "\(answerCount) more answers"
            }
            
        }
        
    }

}
