//
//  AddCalendar.swift
//  ManageStaff
//
//  Created by Hung on 12/8/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import Firebase
import FSCalendar

protocol AddCalendarDelegate {
    func AddCalendar(month: Int, year: Int)
}

class AddCalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    @IBOutlet weak var calendar: FSCalendar!
    var month = Calendar.current.component(.month, from: Date())
    var year = Calendar.current.component(.year, from: Date())
    var blockedDay: [Int] = []
    var delegate:AddCalendarDelegate?
    
    override func viewDidLoad() {
        calendar.allowsMultipleSelection = true
    }
    
    @IBAction func SaveTapped(_ sender: Any) {
        let db = Firestore.firestore()
        db.collection("calendar").document("\(month)-\(year)").setData(["blocked day": blockedDay])
        delegate?.AddCalendar(month: month, year: year)
    }
    
    //add selected day to list
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        month = Calendar.current.component(.month, from: date)
        year = Calendar.current.component(.year, from: date)
        blockedDay.append(Calendar.current.component(.day, from: date))
    }
    
    //remove selected day from list
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let index = blockedDay.firstIndex(of: Calendar.current.component(.day, from: date)){
            blockedDay.remove(at: index)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        month = Calendar.current.component(.month, from: calendar.currentPage)
        year = Calendar.current.component(.year, from: calendar.currentPage)
    }
}
