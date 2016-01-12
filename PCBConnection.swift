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
    case Zone0 = 0
    case Unknown = -1
    
    func description() -> String {
        switch self {
        case Zone1: return "force de frappe"
        case Zone2: return "disponible"
        case Zone0 : return "non disponible"
        default : return "inconnu"
        }
    }
}

class PCBConnection {

    func postRequestForZone(zone: Zone, User user: User)  {
        
        let url:NSURL = NSURL(string: "http://www.vinitysoft.com/tmp_test/upd_status.php")!
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
