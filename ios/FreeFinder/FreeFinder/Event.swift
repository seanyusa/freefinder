//
//  Event.swift
//  FreeFinder
//
//  Created by Sean on 12/27/16.
//  Copyright © 2016 Sean Wang. All rights reserved.
//

import Foundation
import JSONJoy

struct Event : JSONJoy {
    let id: Int
    let eventTitle: String
    let eventTitlePrint: String
    let description: String?
    let startTime: Date
    let startTimePrint: String
    let endTime: String?
    let hyperlink: String?
    let location: String?
    let geoLat: Double?
    let geoLong: Double?
    let extractedFrom: String?
    let freeFood: Bool?
    let freeSwag: Bool?
    let bringResume: Bool?
    let needRSVP: Bool?
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].get()
        eventTitle = try decoder["eventTitle"].get()
        eventTitlePrint = (eventTitle.characters.count > 25) ? eventTitle.substring(to: eventTitle.index(eventTitle.startIndex, offsetBy: 25)) + "..." : eventTitle
        description = decoder["description"].getOptional()
        
        let startTimeString: String = try decoder["startTime"].get()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        startTime = formatter.date(from: startTimeString)!
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        startTimePrint = formatter.string(from: startTime)
        
        endTime = decoder["endTime"].getOptional()
        hyperlink = decoder["hyperlink"].getOptional()
        location = decoder["location"].getOptional()
        geoLat = decoder["geoLat"].getOptional()
        geoLong = decoder["geoLong"].getOptional()
        extractedFrom = decoder["extractedFrom"].getOptional()
        freeFood = decoder["freeFood"].getOptional()
        freeSwag = decoder["freeSwag"].getOptional()
        bringResume = decoder["bringResume"].getOptional()
        needRSVP = decoder["needRSVP"].getOptional()
    }
    
}
