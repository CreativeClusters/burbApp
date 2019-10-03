//
//  CallendarViewController.swift
//  Burb
//
//  Created by Eugene on 29/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import KDCalendar

class CallendarViewController: UIViewController {

    
    
    @IBOutlet weak var calendarView: CalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Availability"
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let today = Date()
        self.calendarView.setDisplayDate(today, animated: true)
    }


}

extension CallendarViewController: CalendarViewDelegate, CalendarViewDataSource {
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date) {
        
    }
    
    func startDate() -> Date {
          var dateComponents = DateComponents()
        dateComponents.month = -3
          let today = Date()
          let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return threeMonthsAgo!
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = +3
          let today = Date()
          let threeMonthsAfter = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return threeMonthsAfter!
    }
    
    
}
