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
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    
    var tweet : Tweet! {
        didSet{
            usernameLabel.text = tweet.user!.name
            profilePic.setImageWithURL(NSURL(string: tweet.user!.profileImageURL!)!)
            tweetLabel.text = tweet.text
            retweetLabel.text = String(tweet.retweet)
            favoriteLabel.text = String(tweet.favorite)
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
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
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        let params = ["id" : tweet.id]
        TwitterClient.sharedInstance.retweetWithID(params as? NSDictionary, id: tweet.id) { (tweet, error) -> () in
            if(tweet != nil){
                self.tweet = tweet!
            }
        }
        self.reloadInputViews()
        
        
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        
    
        
        let params = ["id" : tweet.id]
        TwitterClient.sharedInstance.favoriteWithID(params as? NSDictionary , id: tweet.id) { (tweet, error) -> () in
            if(tweet != nil){
                self.tweet = tweet!
            }
        }
        self.reloadInputViews()
        
    }
    
    
}
