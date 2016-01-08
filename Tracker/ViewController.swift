//
//  ViewController.swift
//  Tracker
//
//  Created by Marco Guilmette on 2015-12-29.
//  Copyright © 2015 Infologique. All rights reserved.
//

import UIKit
import CoreLocation

// 7514
// Latitude:    46.3543992882526

// Longitude:   -72.632473214137
// CLLocationCoordinate2D(latitude: 46.3543992882526, longitude: -72.632473214137)

//GRANBY CLLocationCoordinate2D(latitude: 45.3985158487314, longitude: -72.7236514495825)

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var AvailableSegmentedControl: UISegmentedControl!
    
    
    let locationManager = CLLocationManager()
    let TargetLatitude = 46.3543992882526
    let TargetLongitude = -72.632473214137
    var locationTimer: NSTimer?
    
    var zone: Zone = Zone.Unknown
    
    var available: Bool = true
    
    @IBOutlet var CoreLocationTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //locationManager.stopMonitoringForRegion(regionFrom7514())
        
        //locationManager.startMonitoringForRegion(regionFrom7514())
        
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        //locationManager.distanceFilter = 500
        //locationManager.allowsBackgroundLocationUpdates = true;
        //locationManager.startUpdatingLocation()
        
        //locationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("fireLocationTimer"), userInfo: nil, repeats: true)
 
        //locationManager.requestLocation()
    }
    
    func setZone(zone : Zone){
        
        self.zone = zone
        
        
        switch self.zone {
            case .Zone1 : self.view.backgroundColor = UIColor(netHex: 0x00FF00)
            case .Zone2: self.view.backgroundColor = UIColor(netHex: 0x0000FF)
            case .Unknown: self.view.backgroundColor = UIColor(netHex: 0xFF0000)
        }
        
        
    }
    
    func printLocation(location: CLLocation){
        self.CoreLocationTextView.text = self.CoreLocationTextView.text + "\(location.coordinate.latitude), \(location.coordinate.longitude)\n"
    }
    
    
    @IBAction func HandleLogoutButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.logout()

    }
    
    /*func fireLocationTimer(){
        print(locationManager.location)
        self.CoreLocationTextView.text = self.CoreLocationTextView.text + (locationManager.location?.description)!
        
        locationManager.reque
    }*/
    
    
    /*func regionFrom7514() -> CLCircularRegion {
        
        let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 46.3543992882526, longitude: -72.632473214137)
        
        let region = CLCircularRegion(center: coordinate, radius: 100, identifier: "Target")
        // 2
        region.notifyOnEntry = true
        region.notifyOnExit = true
        return region
    }*/

    @IBAction func HandleAvailableSegmentedControlValueChanged(sender: AnyObject) {
        self.available = (self.AvailableSegmentedControl.selectedSegmentIndex == 0)
        self.AvailableSegmentedControl.tintColor = self.available ? UIColor.blueColor() : UIColor.redColor()
    }
    
    /*
    @IBAction func HandleSendActualPositionButtonAction(sender: AnyObject) {
        self.fireLocationTimer()
    }*/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

