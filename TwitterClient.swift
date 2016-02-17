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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        
        struct Static {
            static let instance =
            TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)

        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            })
            { (error: NSError!) -> Void in
                print("Failed to get request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation : NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("home timeline: \(response)")
            let tweets = Tweet.tweetsWithArray((response as? [NSDictionary])!)
            completion(tweets: tweets, error: nil)
        }, failure: { (response: NSURLSessionDataTask?, error: NSError) -> Void in
            print("Error getting the home timeline")
            completion(tweets: nil, error: error)
        })

    }
    
    func openURL(url: NSURL){
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query) , success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation : NSURLSessionDataTask, response: AnyObject?) -> Void in
                //print("user: \(response)")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (response:NSURLSessionDataTask?, error: NSError) -> Void in
                    print("Error getting the current user")
            })
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive the token")
        }

    }
    
    func retweetWithID(params: NSDictionary?, id: Int, completion : (tweet : Tweet?, error: NSError?) -> ()){
        
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operatin: NSURLSessionDataTask, response:AnyObject?) -> Void in
            var array : [NSDictionary] = [NSDictionary]()
            array.append(response as! NSDictionary)
            let tweets = Tweet.tweetsWithArray(array)
            print("NIRAJ: \(response as! NSDictionary)")
            completion(tweet: tweets[0], error: nil)
            }) { (response: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
        }
    }
    
    func favoriteWithID(params: NSDictionary?, id: Int, completion : (tweet : Tweet?, error: NSError?) -> ()){
        
        POST("1.1/favorites/create.json", parameters: params, success: { (operatin: NSURLSessionDataTask, response:AnyObject?) -> Void in
            var array : [NSDictionary] = [NSDictionary]()
            array.append(response as! NSDictionary)
            let tweets = Tweet.tweetsWithArray(array)
            completion(tweet: tweets[0], error: nil)
            }) { (response: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
        }
    }

}
