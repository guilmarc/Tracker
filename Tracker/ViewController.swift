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

    var zone: Zone = Zone.Unknown
    
    //var available: Bool = true
    
    @IBOutlet var CoreLocationTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //TODO: Force the zone refresh here
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appDelegate.zoneTracker.setOnline()
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

    @IBAction func HandleAvailableSegmentedControlValueChanged(sender: AnyObject) {
        
        if self.AvailableSegmentedControl.selectedSegmentIndex == 0 {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.zoneTracker.setOnline()
        } else {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.zoneTracker.setOffline()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

