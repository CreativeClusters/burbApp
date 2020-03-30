//
//  CalendarTableViewCell.swift
//  Burb
//
//  Created by Eugene on 27.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarTableViewCell: UITableViewCell, NiBLoadable {
    

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }


    
}

extension CalendarTableViewCell {
    
    fileprivate class Decorator {
        
        private init() {}
        
        static func decorate(_ cell: CalendarTableViewCell) {

        }
    }
}

