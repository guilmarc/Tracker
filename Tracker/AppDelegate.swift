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
        
        
        if let user = LoginManager.getUserFromCache() {
            if user.logged {
                if user.userStatus == .Online {
                    zoneTracker.startTrackingForUser(user)
                }
            } else {
                self.showLoginScreen()
            }
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
        LoginManager.user?.logged = false
        LoginManager.user?.userStatus = .Online
        LoginManager.saveUser()
        zoneTracker.stopTracking()
        self.showLoginScreen()
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        LoginManager.saveUser()
    }
    
    
    //MARK: LoginViewControllerDelegate
    
    func LoginViewController(viewController: UIViewController, didLoginWithUser user: User) {
        zoneTracker.startTrackingForUser(user)
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



