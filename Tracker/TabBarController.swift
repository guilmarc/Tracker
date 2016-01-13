//
//  TabBarController.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-12.
//  Copyright © 2016 Infologique. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = UIColor.blackColor()
        self.tabBar.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}
