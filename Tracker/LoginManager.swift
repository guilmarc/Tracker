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
    var firefighterKey: Int
    var firefighterNumber: String
    var barrackLatitude: Double
    var barrackLongitude: Double
    
    //var available: Bool
}

class LoginManager {
    
    static var user : User?

}