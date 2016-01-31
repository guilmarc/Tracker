//
//  LoginManager.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-07.
//  Copyright © 2016 Infologique. All rights reserved.
//

import Foundation
import CoreLocation

let kSavedUser = "SavedUser"

let kUserBarrackUsernameKey = "barrackUsername"
let kUserBarrackPasswordKey = "barrackPassword"
let kUserFirefighterKey = "firefighterKey"
let kUserFirefighterNumberKey = "firefighterNumber"
let kUserBarrackLatitudeKey = "barrackLatitude"
let kUserBarrackLongitudeKey = "barrackLongitude"
let kUserStatus = "status"
let kUserLogged = "logged"

enum UserStatus : Int {
    case Online = 0
    case Offline = 1
}


class User: NSObject, NSCoding {

    var barrackUserName: String
    var barrackPassword: String
    var firefighterKey: Int
    var firefighterNumber: String
    var barrackLatitude: Double
    var barrackLongitude: Double
    var userStatus: UserStatus
    var logged: Bool
    
    init(barrackUsername: String, barrackPassword: String, firefighterKey: Int, firefighterNumber: String, barrackLatitude: Double, barrackLongitude: Double, logged: Bool){
        self.barrackUserName = barrackUsername
        self.barrackPassword = barrackPassword
        self.firefighterKey = firefighterKey
        self.firefighterNumber = firefighterNumber
        self.barrackLatitude = barrackLatitude
        self.barrackLongitude = barrackLongitude
        self.userStatus = UserStatus.Online;
        self.logged = logged
    }
    
    required init?(coder decoder: NSCoder) {
        self.barrackUserName = decoder.decodeObjectForKey(kUserBarrackUsernameKey) as! String
        self.barrackPassword = decoder.decodeObjectForKey(kUserBarrackPasswordKey) as! String
        self.firefighterKey = decoder.decodeIntegerForKey(kUserFirefighterKey)
        self.firefighterNumber = decoder.decodeObjectForKey(kUserFirefighterNumberKey) as! String
        self.barrackLatitude = decoder.decodeDoubleForKey(kUserBarrackLatitudeKey)
        self.barrackLongitude = decoder.decodeDoubleForKey(kUserBarrackLongitudeKey)
        self.userStatus = UserStatus(rawValue: decoder.decodeIntegerForKey(kUserStatus))!
        self.logged = decoder.decodeBoolForKey(kUserLogged)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.barrackUserName, forKey: kUserBarrackUsernameKey)
        coder.encodeObject(self.barrackPassword, forKey: kUserBarrackPasswordKey)
        coder.encodeInteger(self.firefighterKey, forKey: kUserFirefighterKey)
        coder.encodeObject(self.firefighterNumber, forKey: kUserFirefighterNumberKey)
        coder.encodeDouble(self.barrackLatitude, forKey: kUserBarrackLatitudeKey)
        coder.encodeDouble(self.barrackLongitude, forKey: kUserBarrackLongitudeKey)
        coder.encodeInteger(self.userStatus.rawValue, forKey: kUserStatus)
        coder.encodeBool(self.logged, forKey: kUserLogged)
    }
}

class LoginManager {
    
    static var user : User?
    
    
    static func getUserFromCache() -> User? {
        if let savedUser = NSUserDefaults.standardUserDefaults().objectForKey(kSavedUser) {
            if let user = NSKeyedUnarchiver.unarchiveObjectWithData(savedUser as! NSData) as? User {
                self.user = user;
                return user;
            }
        }
        return nil
    }
    
    static func setUser(barrackUsername: String, barrackPassword: String, firefighterKey: Int, firefighterNumber: String, barrackLatitude: Double, barrackLongitude: Double, logged: Bool) {
        
        self.user = User(barrackUsername: barrackUsername, barrackPassword: barrackPassword, firefighterKey: firefighterKey, firefighterNumber: firefighterNumber, barrackLatitude: barrackLatitude, barrackLongitude: barrackLongitude , logged: logged)
       
        saveUser()
        
    }
    
    static func saveUser(){
        let userData = NSKeyedArchiver.archivedDataWithRootObject(self.user!)
        NSUserDefaults.standardUserDefaults().setObject(userData, forKey: kSavedUser)
    }

}