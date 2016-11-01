//
//  RestApiManager.swift
//  FreeFinder
//
//  Created by Sean on 10/31/16.
//  Copyright © 2016 Sean Wang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RestApiManager {
    
    static let shared = RestApiManager()
    
    func getEvents(completion: @escaping (_ data: JSON) -> Void) {
        Alamofire.request("http://172.16.4.11:2400/events/").responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
            }
            completion(JSON(response.result.value))
        }
    }
    
}
