//
//  User.swift
//  Tweet
//
//  Created by Nishant Raman on 2/14/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit


var _currentUser: User?
var currentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileImageURL: String?
    var tagline: String?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }
    
    func logout(){
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        
        get{
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do{
                        if let responseDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue:0)) as? NSDictionary {
                            _currentUser = User(dictionary: responseDictionary)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            return _currentUser
        } set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                do{
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions(rawValue:0))
                    
                        NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                    
                } catch {
                    print(error)
                }
                
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
}
