//
//  CountdownTimer.swift
//  Grcki_Kino
//
//  Created by Ivana Todorovic on 22/10/2020.
//

import Foundation

struct CountdownTimer {
    public var timeLeftString : String = ""
    var timer: Timer?
    
    public mutating func updateTime(date: Date) {
        let userCalendar = Calendar.current
        let today = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: today)
        let currentDate = userCalendar.date(from: components)!
        
        let dateComponents = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
        
        var eventDateComponents = DateComponents()
        eventDateComponents.year = dateComponents.year
        eventDateComponents.month = dateComponents.month
        eventDateComponents.day = dateComponents.day
        eventDateComponents.hour = dateComponents.hour
        eventDateComponents.minute = dateComponents.minute
        eventDateComponents.second = dateComponents.second
        eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+2")
        
        let eventDate = userCalendar.date(from: eventDateComponents)!
        
        let timeLeft = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)
        
        if timeLeft.hour! > 0 {
            timeLeftString = "\(timeLeft.hour!) : \(timeLeft.minute!) : \(timeLeft.second!)"
        } else {
            timeLeftString = "\(timeLeft.minute!) : \(timeLeft.second!)"
        }
        endEvent(currentdate: currentDate, eventdate: eventDate)
    }
    
    mutating func endEvent(currentdate: Date, eventdate: Date) {
        if currentdate >= eventdate {
            timeLeftString = "00:00"
        }
    }
}
