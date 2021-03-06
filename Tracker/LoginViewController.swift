//
//  LoginViewController.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-07.
//  Copyright © 2016 Infologique. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

protocol LoginViewControllerDelegate : NSObjectProtocol {
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
    func LoginViewController(viewController: UIViewController, didLoginWithUser user: User)
}


class LogInViewController: UIViewController, UITextFieldDelegate {

    var delegate: LoginViewControllerDelegate?
    
    @IBOutlet var barrackUserName: UITextField!
    
    @IBOutlet var barrackPassword: UITextField!
    
    @IBOutlet var firefighterNumber: UITextField!
    
    @IBOutlet var firefighterPIN: UITextField!
    
    @IBOutlet var connectionLabel: UILabel!
    
    @IBOutlet var connectionTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Try to load user from cache and assign valut to testfields
        if let user = LoginManager.getUserFromCache() {
            self.barrackUserName.text =  user.barrackUserName
            self.barrackPassword.text = user.barrackPassword
            self.firefighterNumber.text = user.firefighterNumber
            //self.firefighterPIN.text = String(user.firefighterKey)
        
        }
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillAppear(notification: NSNotification){
        // If this is an iPhone 4
        if UIScreen.mainScreen().nativeBounds.height < 1136 {
            self.connectionTopConstraint.constant = -30
        }
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        self.connectionTopConstraint.constant = 23
    }
    

    @IBAction func HandleLoginButtonAction(sender: AnyObject) {
        self.validateLogin()
    }
    
    func validateLogin(){
        guard self.barrackUserName.text != "" else {
            self.barrackUserName.becomeFirstResponder()
            return
        }
        
        guard self.barrackPassword.text != "" else {
            self.barrackPassword.becomeFirstResponder()
            return
        }
        
        guard self.firefighterNumber.text != "" else {
            self.firefighterNumber.becomeFirstResponder()
            return
        }
        
        guard self.firefighterPIN.text != "" else {
            self.firefighterPIN.becomeFirstResponder()
            return
        }
        
        postLoginRequest()
    }
    
    
    func loginWasSuccessfulWithKey(key: Int, Latitude latitude: Double, andLongitude longitude: Double)
    {
        //Saving cache data
        LoginManager.setUser(self.barrackUserName.text!, barrackPassword: self.barrackPassword.text!, firefighterKey: key, firefighterNumber: self.firefighterNumber.text!, barrackLatitude: latitude, barrackLongitude: longitude , logged: true)
        
        
        //Fire the appropriate delegate event
        delegate?.LoginViewController(self, didLoginWithUser: LoginManager.user!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //http://www.personalconsultboard.com/tmp_test/auth_check.php
    //Les valeurs que tu devras poster sont :
    //in_Cas_UserName = Le user name de la caserne
    //in_Cas_Password = Le mot de passe de la caserne
    //in_NoPompier = Le numéro du pompier (valeur numérique (int))
    //in_NipPompier = Le NIP du pompier (valeur numérique (int))
    func buildRequest() -> NSMutableURLRequest {
        let url:NSURL = NSURL(string: "http://www.vinitysoft.com/pcb/tracker/auth_check_post.php")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        //let paramString = "in_Cas_UserName=stcesaire&in_Cas_Password=085085&in_NoPompier=122&in_NipPompier=0"
        
        let paramString = "in_Cas_UserName=\(self.barrackUserName.text!)&in_Cas_Password=\(self.barrackPassword.text!)&in_NoPompier=\(self.firefighterNumber.text!)&in_NipPompier=\(self.firefighterPIN.text!)"
        
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        return request
    }
    
    
    func postLoginRequest() {
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(buildRequest()) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                
                
                return
            }

            if let dataString = String(data: data!, encoding: NSUTF8StringEncoding) {
                
                let params = dataString.componentsSeparatedByString(";")
                
                if let key = Int(params[0]) {
                    print(key)
                    
                    guard key != 0 else {
                        print("Invalid login !!!!!!!!!")
                        dispatch_async(dispatch_get_main_queue(),{
                            showSimpleAlertWithTitle(nil, message: "Connection refusée", viewController: self)
                        })
                        return
                    }
                    
                    guard params.count >= 3 else {
                        dispatch_async(dispatch_get_main_queue(),{
                            showSimpleAlertWithTitle(nil, message: "Erreur: Trop peu de paramètres", viewController: self)
                        })
                        return
                    }
                    
                    if let longitude = Double(params[1]), let latitude = Double(params[2]) {
                        self.loginWasSuccessfulWithKey(key, Latitude: latitude, andLongitude: longitude)
                    } else {
                        dispatch_async(dispatch_get_main_queue(),{
                            showSimpleAlertWithTitle(nil, message: "Erreur: Paramètres invalides", viewController: self)
                        })
                    }
                }
            }
        }
        
        task.resume()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.validateLogin()
        return true;
    }// called when 'return' key pressed. return NO to ignore.
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


