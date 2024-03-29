//
//  Calender.swift
//  HashTag
//
//  Created by Trend-HuB on 13/03/1445 AH.
//

import Foundation
import UIKit
import FSCalendar

extension EventsVC:FSCalendarDelegate,FSCalendarDataSource ,FSCalendarDelegateAppearance{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: date)
        
        filteredEvents = []
        for event in self.eventVM?.eventsArray ?? [] {
            let arr = event?.start_at.split(separator: " ")
            if arr?.first ?? "" == General.changeArabicNumbers(arabicNum: selectedDate) {
                filteredEvents.append(event!)
            }
        }
        calenderTable.reloadData()
    }
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter2.string(from: calendar.currentPage))")
    }
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        
        if self.eventVM?.eventsArray?.count ?? 0 > 0{
            var matchedEvents : [EventModel] = []
            for event in self.eventVM?.eventsArray ?? []
            {
                let arr = event?.start_at.split(separator: " ")
                if arr?.first ?? "" == General.changeArabicNumbers(arabicNum: dateString)
                {
                    matchedEvents.append(event!)
                }
            }
            
            if matchedEvents.count > 0
            {
                return 1
            }else
            {
                return 0
            }
        }else
        {
            return 0
        }
        
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let dateString = self.dateFormatter2.string(from: date)
        if self.eventVM?.eventsArray?.count ?? 0 > 0{
            var matchedEvents : [EventModel] = []
            for event in self.eventVM?.eventsArray ?? [] {
                let arr = event?.start_at.split(separator: " ")
                if arr?.first ?? "" == General.changeArabicNumbers(arabicNum: dateString)  {
                    matchedEvents.append(event!)
                }
            }
            if matchedEvents.count > 0 {
                return [Colors.PrimaryColor]
            }else {
                return nil
            }
        }else{
            return nil
        }
    }
    
}
