//
//  TweetsViewController.swift
//  Tweet
//
//  Created by Nishant Raman on 2/14/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
    
    var cell: TweetCell!
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func onLogout(sender: AnyObject){
        User.currentUser?.logout()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        
        cell.profilePic.userInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        cell.profilePic.addGestureRecognizer(tapRecognizer)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("pushSegue", sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let pushViewController = segue.destinationViewController as! PushViewController
        let indexPath = tableView.indexPathForCell(cell)
        pushViewController.tweet = tweets![indexPath!.row]

        
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        let profileViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        
        let tapLocation = gestureRecognizer.locationInView(self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath!) as! TweetCell
        
        profileViewController.user = cell.tweet.user
        
        self.navigationController!.pushViewController(profileViewController, animated: true)

    }
    
    
     
}
