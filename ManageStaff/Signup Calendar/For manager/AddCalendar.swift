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

// to send data back
protocol AddCalendarDelegate {
    func AddCalendar(month: Int, year: Int)
}


class AddCalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    
    
    
    //MARK: outlets and variables
    @IBOutlet weak var calendar: FSCalendar!
    var mode: String = ""
    var date = Date()
    var blockedDay: [Int] = []
    var delegate:AddCalendarDelegate?
    var ref: DatabaseReference!
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    
    //MARK: View
    override func viewDidLoad() {
        ref = Database.database().reference()
        calendar.allowsMultipleSelection = true
        calendar.setCurrentPage(Date(), animated: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        //if a list of blocked days is sent by the previous view (we are in update mode) -> display blocked days onto the calendar
        for day in blockedDay {
            self.calendar.select(formatter.date(from: "\(day)/\(Calendar.current.component(.month, from: date))/\(Calendar.current.component(.year, from: date))"))
        }
    }

    
    
    //MARK: handle save button
    @IBAction func SaveTapped(_ sender: Any) {
        date = calendar.currentPage
        
        self.ref.child("schedule").child("\(Calendar.current.component(.month, from: date))-\(Calendar.current.component(.year, from: date))").setValue([
            "blocked day": blockedDay
        ])
        
        for i in 1...maxDayOfMonth(month: Calendar.current.component(.month, from: date), year: Calendar.current.component(.year, from: date)){
            
            if blockedDay.firstIndex(of: i) == nil{
                self.ref.child("schedule").child("\(Calendar.current.component(.month, from: date))-\(Calendar.current.component(.year, from: date))").child(String(i)).setValue([
                    "registered": 0,
                    "maxStaff": 5,
                    "task": 5
                ])
            } else {
                self.ref.child("schedule").child("\(Calendar.current.component(.month, from: date))-\(Calendar.current.component(.year, from: date))").child(String(i)).removeValue()
            }
        }
        
        
        delegate?.AddCalendar(month: (Calendar.current.component(.month, from: date)), year: (Calendar.current.component(.year, from: date)))
    }
    
    
    
    
    //MARK: handle blocked days selection
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
    
    func maxDayOfMonth(month: Int, year: Int) -> Int  {
        var rt = 0
        
        switch month {
        case 1, 3, 7, 8, 10, 12:
            rt = 31
        case 4, 6, 9, 11:
            rt = 30
        case 2:
            if year % 4 == 0 && year % 100 != 0 || year % 400 == 0{
                rt = 29
            } else {
                rt = 28
            }
        default:
            rt = 31
        }
        
        return rt
    }
}
