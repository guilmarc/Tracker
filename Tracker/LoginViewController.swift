//
//  LoginViewController.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-07.
//  Copyright © 2016 Infologique. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet var barrackUserName: UITextField!
    
    @IBOutlet var barrackPassword: UITextField!
    
    @IBOutlet var firefighterNumber: UITextField!
    
    @IBOutlet var firefighterPIN: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func HandleLoginButtonAction(sender: AnyObject) {
        
        
        //LoginManager.user?.barrackUserName = self.barrackUserName.text
        
        
        loginWasSuccessful()
    }
    
    func loginWasSuccessful()
    {
    
        NSNotificationCenter.defaultCenter().postNotificationName("LoginSuccessful", object: self)    // Send notification
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    func loadFromCache(){
        
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
