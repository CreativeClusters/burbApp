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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let today = Date()
        self.calendarView.setDisplayDate(today, animated: true)
    }


}

