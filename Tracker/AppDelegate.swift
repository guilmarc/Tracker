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
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate,  LoginViewControllerDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    let connection = PCBConnection()
    
    var zone : Zone = Zone.Unknown
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Sound , .Alert , .Badge], categories: nil))
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        locationManager.delegate = self                // Add this line
        locationManager.requestAlwaysAuthorization()   // And this one
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.allowsBackgroundLocationUpdates = true;
        
        
        if (!LoginManager.authenticated) {
            self.showLoginScreen()
        }
        
        return true
    }

    
    func LoginViewController(viewController: UIViewController, didLoginWithUser user: User) {
        
        //locationManager.startUpdatingLocation()
        LocationTracker.sharedInstance.startMonitoringRegionsForUser(user)
        
    }
    
    func showLoginScreen(){
        // Get login screen from storyboard and present it
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewControllerWithIdentifier("Login") as! LogInViewController
        loginViewController.delegate = self
        
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController?.presentViewController(loginViewController, animated: true, completion: nil)

    }

    
    func logout(){
        // Remove data from singleton (where all my app data is stored)
        //[AppData clearData];
        locationManager.stopUpdatingLocation()
        
        self.showLoginScreen()
        
        // Reset view controller (this will quickly clear all the views)
        //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        //MainTabControllerViewController *viewController = (MainTabControllerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        //[self.window setRootViewController:viewController];
        
        // Show login screen
        //[self showLoginScreen:NO];
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func handleRegionEvent(region: CLRegion!, mode: CLRegionMode) {
        let message = (mode == CLRegionMode.Enter ? "Vous venez d'entrer dans la zone::\(region.identifier)" : "Vous venez de quitter la zone::\(region.identifier)")
        
        // Show an alert if application is active
        if UIApplication.sharedApplication().applicationState == .Active {
            
            if let viewController = (window?.rootViewController as? UINavigationController)?.viewControllers.first as? ViewController  {
                //if let viewController = navigationController.vi .rootViewController as ViewController {
                if (mode == CLRegionMode.Enter) {
                    viewController.setZone(region.identifier)
                } else {
                    viewController.setZone("Exit")
                }
            }
            
        } else {
            // Otherwise present a local notification
            let notification = UILocalNotification()
            notification.alertBody = message
            notification.soundName = "Default";
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            print("didEnterRegion::\(region.identifier)")
            handleRegionEvent(region, mode: CLRegionMode.Enter)
        }
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            print("didExitRegion::\(region.identifier)")
            handleRegionEvent(region, mode: CLRegionMode.Exit)
        }
    }
        
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let message = "New location (\(locations.count)) \(locations[0].coordinate)"
        
        var zone: Zone?
        zone = connection.requestZoneFromLocation(locations.last!)
        
        //Exit if we are in the same zone
        //guard self.zone == zone else {
        //    return
        //}
      
        // if application is active
        if UIApplication.sharedApplication().applicationState == .Active {
            if let viewController = (window?.rootViewController as? UINavigationController)?.viewControllers.first as? ViewController  {
                //if let viewController = navigationController.vi .rootViewController as ViewController {
                    //viewController.setZone(zone!)
                    viewController.printLocation(locations.last!)
                    //showSimpleAlertWithTitle(nil, message: message, viewController: viewController)
                //}
            }
        //
        } else {
            // Otherwise present a local notification
            let notification = UILocalNotification()
            notification.alertBody = message
            notification.soundName = "Default";
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
        

        
        
    }


}



