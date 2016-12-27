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
    let description: String?
    let startTime: Date
    let endTime: Date?
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
        description = decoder["description"].getOptional()
        startTime = try decoder["startTime"].get()
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
