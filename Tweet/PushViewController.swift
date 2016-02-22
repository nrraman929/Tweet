//
//  PushViewController.swift
//  Tweet
//
//  Created by Nishant Raman on 2/20/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {
    
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var favortiesLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tweet : Tweet!
    override func viewDidLoad() {
        
    
            nameLabel.text = tweet.user!.name
            profPic.setImageWithURL(NSURL(string: tweet.user!.profileImageURL!)!)
            tweetLabel.text = tweet.text
            retweetsLabel.text = String(tweet.retweet)
            favortiesLabel.text = String(tweet.favorite)
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            dateLabel.text = formatter.stringFromDate(tweet.createdAt!)
            usernameLabel.text = "@" + tweet.screenname!
        }
    
    

}
