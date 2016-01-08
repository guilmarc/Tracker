//
//  LocationTracker.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-01.
//  Copyright © 2016 Infologique. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

//751 CLLocationCoordinate2D(latitude: 46.3543992882526, longitude: -72.632473214137)

//GRANBY CLLocationCoordinate2D(latitude: 45.3985158487314, longitude: -72.7236514495825)


class LocationTracker : NSObject, CLLocationManagerDelegate {
    
    class var sharedInstance: LocationTracker {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: LocationTracker? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = LocationTracker()
        }
        return Static.instance!
    }
    
    
    var lastLocation: CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    
    /*func startTracker() {
        locationManager.stopMonitoringForRegion(regionFrom7514())
        
        locationManager.startMonitoringForRegion(regionFrom7514())
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.distanceFilter = 500
        locationManager.allowsBackgroundLocationUpdates = true;
        locationManager.startUpdatingLocation()
    }*/
    
    private func stopMonitoringRegionsForUser(user: User){
        for region in regionsFromUser(user) {
            locationManager.stopMonitoringForRegion(region)
        }
    }
    
    func startMonitoringRegionsForUser(user: User){
        for region in regionsFromUser(user) {
            locationManager.startMonitoringForRegion(region)
        }
    }
    
    func regionsFromUser(user: User) -> [CLCircularRegion] {
        
        let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 46.3543992882526 , longitude: -72.632473214137)
        
        var regions = [CLCircularRegion]()
        
        let region2 = CLCircularRegion(center: coordinate, radius: 20000, identifier: "Zone2")
        region2.notifyOnEntry = true
        region2.notifyOnExit = true
        regions.append(region2)
        
        let region1 = CLCircularRegion(center: coordinate, radius: 4000, identifier: "Zone1")
        region1.notifyOnEntry = true
        region1.notifyOnExit = true
        regions.append(region1)
        
        return regions
    }
    
    
    func test(){
        
    }
    /*
    func regionFrom7514() -> CLCircularRegion {
        
        let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 46.3543992882526, longitude: -72.632473214137)
        
        let region = CLCircularRegion(center: coordinate, radius: 100, identifier: "Target")
        // 2
        region.notifyOnEntry = true
        region.notifyOnExit = true
        return region
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }*/
    
    
}
