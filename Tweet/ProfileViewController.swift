//
//  ProfileViewController.swift
//  Tweet
//
//  Created by Nishant Raman on 2/21/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
   // @IBOutlet weak var coverPhot: UIImageView!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var coverPhoto: UIImageView!
    
    var user: User!
    
    override func viewDidLoad() {
        //coverPhot.setImageWithURL(NSURL(string: user!.coverImageURL!)!)
        
        profPic.setImageWithURL(NSURL(string: user!.profileImageURL!)!)
        coverPhoto.setImageWithURL(NSURL(string: user!.coverImageURL!)!)
        numTweets.text = String(user.tweets)
        numFollowers.text = String(user.followers)
        numFollowing.text = String(user.following)
    }
    
    

}
