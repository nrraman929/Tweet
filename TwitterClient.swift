//
//  TwitterClient.swift
//  Tweet
//
//  Created by Nishant Raman on 2/14/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "IlWEpudHPzqBZZ207XsCc2Yh2"
let twitterConsumerSecret = "MgrLwxZtDHHEmpBozFPYLJlKWLAUf17W4XauCoWJHtrih861Q9"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        
        struct Static {
            static let instance =
            TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)

        }
        
        return Static.instance
    }

}
