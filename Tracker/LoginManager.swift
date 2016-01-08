//
//  LoginManager.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-07.
//  Copyright © 2016 Infologique. All rights reserved.
//

import Foundation

struct User {
    var barrackUserName: String
    var barrackPassword: String
    var firefighterNumber: String
}

class LoginManager {
    
    static var user : User?
    private var authenticated = false
    private var loginViewController: LoginViewController?
    
    
    func loginWithUsername(){
        
    }
    
    /*func getUser() -> User? {
        if () {
            
        }
        
        let storyboard = UIStoryboard(name: "MyStoryboardName", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("someViewController") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        
        return nil
    }*/
    
    
    
    
}