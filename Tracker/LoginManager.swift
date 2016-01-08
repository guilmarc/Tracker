//
//  LoginManager.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-07.
//  Copyright © 2016 Infologique. All rights reserved.
//

import Foundation
import CoreLocation

struct User {
    var barrackUserName: String
    var barrackPassword: String
    var firefighterNumber: String
    var barrackLongitude: Double
    var barrackLatitude: Double
}

class LoginManager {
    
    static var user : User?
    static var authenticated = false
    
    private var loginViewController: LogInViewController?
    
    
    func loginWithUsername(username: String, password: String, number: String, PIN : String){
        
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