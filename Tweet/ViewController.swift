//
//  ViewController.swift
//  Tweet
//
//  Created by Nishant Raman on 2/10/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
               
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){ (user: User?, error: NSError?) in
            if let u = user {
                //perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // handle login error
            }
        }
        
    }
}

