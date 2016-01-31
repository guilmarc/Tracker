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

class TrackerViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var AvailableSegmentedControl: UISegmentedControl!

    var zone: Zone = Zone.Unknown
    
    //var available: Bool = true
    @IBOutlet var LocationImageView: UIImageView!
    
    @IBOutlet var CoreLocationTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationController?.navigationBarHidden = true
        //Try to load user from cache and assign valut to testfields

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //TODO: Force the zone refresh here
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appDelegate.zoneTracker.setOnline()
        if let user = LoginManager.user {
            self.AvailableSegmentedControl.selectedSegmentIndex = user.userStatus.rawValue
            
            //self.setZone(.Zone0)
            //self.firefighterPIN.text = String(user.firefighterKey)
            
            //Patch
            self.HandleAvailableSegmentedControlValueChanged(UISegmentedControl())
        }
    }
    
    func setZone(zone : Zone){
        
        self.zone = zone
        
        switch self.zone {
            case .Zone1 : self.LocationImageView.image = UIImage(named: "location-green")
            case .Zone2: self.LocationImageView.image = UIImage(named: "location-blue")
            case .Zone0: self.LocationImageView.image = UIImage(named: "location-red")
            case .Unknown: self.LocationImageView.image = UIImage(named: "location-white")
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
        
        //Saving value to the user class
        LoginManager.user!.userStatus = UserStatus(rawValue:self.AvailableSegmentedControl.selectedSegmentIndex)!
        
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

