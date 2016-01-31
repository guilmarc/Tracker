//
//  AppDelegate.swift
//  Tracker
//
//  Created by Marco Guilmette on 2015-12-29.
//  Copyright © 2015 Infologique. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoginViewControllerDelegate, ZoneTrackerDelegate {

    var window: UIWindow?
    let connection = PCBConnection()
    let zoneTracker = ZoneTracker()
    var trackerViewController : TrackerViewController?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Register the application for future notifications
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Sound , .Alert , .Badge], categories: nil))
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        //Assigning trackerViewController for future use
        self.trackerViewController = (window?.rootViewController as? UINavigationController)?.viewControllers.first as? TrackerViewController
    
        //Set self as delegate of ZoneTracker
        zoneTracker.delegate = self
        
        if let _ = LoginManager.getUserFromCache()?.logged {
            zoneTracker.startTrackingForUser(LoginManager.user!)
        } else {
            self.showLoginScreen()
        }
        
        return true
    }
    
    
    func showLoginScreen(){
        // Get login screen from storyboard and present it
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewControllerWithIdentifier("Login") as! LogInViewController
        loginViewController.delegate = self
        
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController?.presentViewController(loginViewController, animated: false, completion: nil)

    }

    
    //This fonction if not used.  Logout must be done by killing the app
    func logout(){
        zoneTracker.stopTracking()
        self.showLoginScreen()
    }
    
    //MARK: LoginViewControllerDelegate
    
    func LoginViewController(viewController: UIViewController, didLoginWithUser user: User) {
        
        //locationManager.startUpdatingLocation()
        //LocationTracker.sharedInstance.startMonitoringRegionsForUser(user)
        //zoneTracker.targetLocation = CLLocation(latitude: user.barrackLatitude, longitude: user.barrackLongitude)
        
        //print("LOGIN Latitude = \(user.barrackLatitude)")
        //print("LOGIN Longitude = \(user.barrackLongitude)")
        
        zoneTracker.targetLocation = CLLocation(latitude: user.barrackLatitude, longitude: user.barrackLongitude)
        //zoneTracker.targetLocation = CLLocation(latitude: 46.171607, longitude: -71.8778427)
        
        //print("AFTER Latitude = \(zoneTracker.targetLocation.coordinate.latitude)")
        //print("AFTER Longitude = \(zoneTracker.targetLocation.coordinate.longitude)")
        
        zoneTracker.startTracking()
    }

    // MARK: ZoneTrackerDelegate
    
    func zoneTracker(zoneTracker: ZoneTracker, didMoveToZone zone: Zone){
        
        //Development purpose only
        print(zone)
        
        let message = "Vous êtes maintenant dans l'état \(zone.description())"
        
        trackerViewController?.setZone(zone)
        
        // if application is active
        if UIApplication.sharedApplication().applicationState != .Active {
            let notification = UILocalNotification()
            notification.alertBody = message
            notification.soundName = "Default";
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
        
        connection.postRequestForZone(zone, User: LoginManager.user!)
    }
    
}



