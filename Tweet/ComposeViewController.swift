//
//  ComposeViewController.swift
//  Tweet
//
//  Created by Nishant Raman on 2/24/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profPic.setImageWithURL(NSURL(string: (User.currentUser?.profileImageURL)!)!)
        nameLabel.text = User.currentUser?.name
        screennameLabel.text = "@" + (User.currentUser?.screenname)!
        
    }
    @IBAction func onClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
extension ComposeViewController : UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //This is where we will call the tweet function and then dismiss controller
        let params = ["status" : textField.text!]
        TwitterClient.sharedInstance.postTweet(params)
        self.onClose(self)
        
        
        return true
    }
    
}
