//
//  ZoneManager.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-08.
//  Copyright © 2016 Infologique. All rights reserved.
//

import Foundation
import CoreLocation

protocol ZoneManagerDelegate {

    /*
    *  LoginViewController:didLoginWithUser:
    *
    *  Discussion:
    *    Invoked when new locations are available.  Required for delivery of
    *    deferred locations.  If implemented, updates will
    *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
    *
    *    locations is an array of CLLocation objects in chronological order.
    */
    func zoneManager(zoneManager: ZoneManager, didMoveToZone zone: Zone)
}

class ZoneManager {
    
}