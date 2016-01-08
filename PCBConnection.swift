//
//  LocationUpdater.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-02.
//  Copyright © 2016 Infologique. All rights reserved.
//

import Foundation
import CoreLocation

/*enum Zone: Int {
    case Zone1 = 0x00FF00
    case Zone2 = 0x0000FF
    case Unknown = 0xFF0000
}*/

enum Zone: Int {
    case Zone1 = 1
    case Zone2 = 2
    case Unknown = 0
}

class PCBConnection {

    func postRequestForZone(zone: Zone, User user: User)  {
        
        let url:NSURL = NSURL(string: "http://www.vinitysoft.com/tmp_test/auth_check_post.php")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let paramString = "noSeqPompier=\(user.firefighterKey)&status=\(zone.rawValue)"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
        }
        
        task.resume()
    }
    
}
