//
//  Week.swift
//  FreeFinder
//
//  Created by Sean on 12/27/16.
//  Copyright © 2016 Sean Wang. All rights reserved.
//

import Foundation

struct Week {
    let startDate: Date
    let endDate: Date
    let startOfNextWeek: Date
    let displayName: String
    var events: [Event] = [Event]()
    
    init(startDate: Date) {
        self.startDate = startDate
        self.endDate = startDate.addingTimeInterval(604799)
        self.startOfNextWeek = startDate.addingTimeInterval(604800)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let dateString = formatter.string(from: startDate)
        let commaRange = dateString.range(of: ",")
        displayName = "Week of " + dateString.substring(to: (commaRange?.lowerBound)!)
    }
    
    func test() {
        print(Date().addingTimeInterval(604800))
    }
}
