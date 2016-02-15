//
//  TweetCell.swift
//  Tweet
//
//  Created by Nishant Raman on 2/15/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet : Tweet! {
        didSet{
            usernameLabel.text = tweet.user!.name
            profilePic.setImageWithURL(NSURL(string: tweet.user!.profileImageURL!)!)
            tweetLabel.text = tweet.text
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            print(formatter.stringFromDate(tweet.createdAt!))
            timestampLabel.text = formatter.stringFromDate(tweet.createdAt!)
            
            
        }
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        usernameLabel.preferredMaxLayoutWidth = usernameLabel.frame.size.width
        
    }
    
    override func awakeFromNib() {
        profilePic.layer.cornerRadius = 3
        profilePic.clipsToBounds = true
        
        usernameLabel.preferredMaxLayoutWidth = usernameLabel.frame.size.width
        
    }
}
