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
    func UpdateCalendar(month: Int, year: Int)
}

class AddCalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    @IBOutlet weak var calendar: FSCalendar!
    var mode: String = ""
    var date = Date()
    var blockedDay: [Int] = []
    var delegate:AddCalendarDelegate?
    
    override func viewDidLoad() {
        calendar.allowsMultipleSelection = true
        calendar.setCurrentPage(Date(), animated: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        for day in blockedDay {
            self.calendar.select(formatter.date(from: "\(day)/\(Calendar.current.component(.month, from: date))/\(Calendar.current.component(.year, from: date))"))
        }
    }

    
    @IBAction func SaveTapped(_ sender: Any) {
        date = calendar.currentPage
        let db = Firestore.firestore()
        db.collection("calendar").document("\(Calendar.current.component(.month, from: date))-\(Calendar.current.component(.year, from: date))").setData(["blocked day": blockedDay])
        delegate?.AddCalendar(month: (Calendar.current.component(.month, from: date)), year: (Calendar.current.component(.year, from: date)))
    }
    
    //add selected day to list
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        blockedDay.append(Calendar.current.component(.day, from: date))
    }
    
    //remove selected day from list
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let index = blockedDay.firstIndex(of: Calendar.current.component(.day, from: date)){
            blockedDay.remove(at: index)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        blockedDay = []
    }
}
