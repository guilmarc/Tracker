//
//  ZoneTracker.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-08.
//  Copyright © 2016 Infologique. All rights reserved.
//

import Foundation
import CoreLocation

protocol ZoneTrackerDelegate  {

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
    func zoneTracker(zoneTracker: ZoneTracker, didMoveToZone zone: Zone)
}


class ZoneTracker: NSObject, CLLocationManagerDelegate {
    
    var delegate: ZoneTrackerDelegate?
    
    let locationManager = CLLocationManager()
    
    var currentZone = Zone.Unknown
    
    var targetLocation = CLLocation(latitude: 46.3543992882526, longitude: -72.632473214137)
    
    override init () {
        super.init()
        locationManager.delegate = self                // Add this line
        locationManager.requestAlwaysAuthorization()   // And this one
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1
        locationManager.allowsBackgroundLocationUpdates = true;
    }
    
    //func setTargetLocation(location : CLLocation){
    //    self.targetLocation = location
    //}
    
    func startTracking(){
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking(){
        locationManager.stopUpdatingLocation()
    }
    
    func setOnline(){
        //self.locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    func setOffline(){
        if self.currentZone != Zone.Zone0 {
            self.currentZone = Zone.Zone0
            delegate?.zoneTracker(self, didMoveToZone: Zone.Zone0)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations.last)
        
        
        let distance = locations.last!.distanceFromLocation(targetLocation)
        
        print(distance)
        
        if (distance < 4000) {
            if self.currentZone != Zone.Zone1 {
                self.currentZone = Zone.Zone1
                delegate?.zoneTracker(self, didMoveToZone: Zone.Zone1)
            }
            return
        }
        
        if (distance < 10000) {
            if self.currentZone != Zone.Zone2 {
                self.currentZone = Zone.Zone2
                delegate?.zoneTracker(self, didMoveToZone: Zone.Zone2)
            }
            return
        }
        
        if self.currentZone != Zone.Zone0 {
            self.currentZone = Zone.Zone0
            delegate?.zoneTracker(self, didMoveToZone: Zone.Zone0)
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
        
    
    
}