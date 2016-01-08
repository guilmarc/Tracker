//
//  LoginViewController.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-07.
//  Copyright © 2016 Infologique. All rights reserved.
//

import UIKit
import CoreLocation

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


class LogInViewController: UIViewController {

    var delegate: LoginViewControllerDelegate?
    
    @IBOutlet var barrackUserName: UITextField!
    
    @IBOutlet var barrackPassword: UITextField!
    
    @IBOutlet var firefighterNumber: UITextField!
    
    @IBOutlet var firefighterPIN: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func HandleLoginButtonAction(sender: AnyObject) {

        
        postLoginRequest()
    }
    
    func loginWasSuccessful()
    {
        
        //Saving cache data
        LoginManager.user = User(barrackUserName: self.barrackUserName.text!, barrackPassword: self.barrackPassword.text!, firefighterNumber: self.firefighterNumber.text!, barrackLongitude: 46.3543992882526, barrackLatitude: -72.632473214137)
        
        LoginManager.authenticated = true
        
        //Fire the appropriate delegate event
        delegate?.LoginViewController(self, didLoginWithUser: LoginManager.user!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //http://www.personalconsultboard.com/tmp_test/auth_form.html
    //http://www.personalconsultboard.com/tmp_test/auth_check.php
    //Les valeurs que tu devras poster sont :
    //in_Cas_UserName = Le user name de la caserne
    //in_Cas_Password = Le mot de passe de la caserne
    //in_NoPompier = Le numéro du pompier (valeur numérique (int))
    //in_NipPompier = Le NIP du pompier (valeur numérique (int))
    func buildRequest() -> NSMutableURLRequest {
        let url:NSURL = NSURL(string: "http://www.personalconsultboard.com/tmp_test/auth_check.php")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        //let paramString = "in_Cas_UserName=stcesaire&in_Cas_Password=085085&in_NoPompier=122&in_NipPompier=0"
        
        //let paramString = "in_Cas_UserName=\(self.barrackUserName.text!)&in_Cas_Password=\(self.barrackPassword.text!)&in_NoPompier=\(self.firefighterNumber.text!)&in_NipPompier=\(self.firefighterPIN.text!)"
        //request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        //print("\(request)\n\n\n")
        
        return request
    }
    
    
    func postLoginRequest() {
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(buildRequest()) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                //TODO: Remove this when WebService will Work
                self.loginWasSuccessful()
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
            
            self.loginWasSuccessful()
            
        }
        
        task.resume()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


