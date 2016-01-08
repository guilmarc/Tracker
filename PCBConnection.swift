//
//  LocationUpdater.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-02.
//  Copyright © 2016 Infologique. All rights reserved.
//

import Foundation
import CoreLocation

enum Zone: Int {
    case Zone1 = 0x00FF00
    case Zone2 = 0x0000FF
    case Unknown = 0xFF0000
}

class PCBConnection {
    
    let url:NSURL = NSURL(string: "http://www.webservicex.net/ConvertTemperature.asmx/ConvertTemp")!
    
    func requestZoneFromLocation(location : CLLocation) -> Zone {
        
        
        let distance = location.distanceFromLocation(CLLocation(latitude: 46.3543992882526, longitude: -72.632473214137))
        
        if (distance < 500) {
            return Zone.Zone1
        }
        
        if (distance < 1000) {
            return Zone.Zone2
        }
        
        return Zone.Unknown
        
        //return self.postRequest(buildRequestFromLocation(location))
    
    }
    
    func buildRequestFromLocation(location: CLLocation ) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&status=1"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        return request
    }

    
    func postRequest(request: NSMutableURLRequest) -> Zone {
    
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                dispatch_async(dispatch_get_main_queue(),{
                    //self.responseTextView.text = "error"
                })
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
    
            
            dispatch_async(dispatch_get_main_queue(),{
                //self.responseTextView.text = dataString?.stringByStandardizingPath
            })
            
        }
        
        task.resume()
        
        return Zone.Zone2
    }
    
}
