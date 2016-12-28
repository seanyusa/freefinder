//
//  WeekParserService.swift
//  FreeFinder
//
//  Created by Sean on 12/27/16.
//  Copyright © 2016 Sean Wang. All rights reserved.
//

import Foundation

class WeekParserService {
    
    static let shared = WeekParserService()
    
    var thisWeek: Week {
        return Week(startDate: Date().startOfWeek!)
    }
    
    // Assuing events are in sorted order by date.
    func getEventsByWeeks(events: [Event]) -> [Week] {
        var resultList = [Week]()
        var currentWeek = thisWeek
        
        for event in events {
            if currentWeek.startDate.compare(event.startTime) == .orderedAscending {
                if event.startTime.compare(currentWeek.endDate) == .orderedAscending {
                    // In this week
                    currentWeek.events.append(event)
                } else {
                    // Otherwise futher than this week. Skip to that week.
                    resultList.append(currentWeek)
                    currentWeek = Week(startDate: event.startTime.startOfWeek!)
                    currentWeek.events.append(event)
                }
            }
        }
        resultList.append(currentWeek)
        print(resultList)
        return resultList
    }
}

extension Date {
    struct Gregorian {
        static let calendar = Calendar(identifier: .gregorian)
    }
    var startOfWeek: Date? {
        return Gregorian.calendar.date(from: Gregorian.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
}
