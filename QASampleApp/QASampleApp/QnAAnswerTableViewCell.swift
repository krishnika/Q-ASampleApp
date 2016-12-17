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
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                self.userImage.image = UIImage(data: data)
            }
        }
    }
    
    func configureCell(post: Post) {
        
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        
        questionLabel.text = post.postBody ?? Utility.kNullConstant
        
        let answers = post.answers
        
        let answerCount = answers.count
        
        if answerCount > 0 {
            answerLabel.text = answers[0].answerBody ?? Utility.kNullConstant
            if let user = answers[0].user {
                
                userName.text = user.name ?? Utility.kNullConstant
                if let imageUrl = user.profilePic {
                    userImage.contentMode = UIViewContentMode.scaleAspectFit
                    if let url = URL(string: imageUrl) {
                        downloadImage(url: url)
                    }
                    
                }
                
            }
            
            if answerCount > 1 {
                answerCountLabel.text = "\(answerCount) more answers"
            }
            
        }
        
    }

}
