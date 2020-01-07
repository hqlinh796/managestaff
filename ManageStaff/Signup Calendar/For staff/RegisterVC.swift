//
//  RegisterVC.swift
//  ManageStaff
//
//  Created by Hung on 12/10/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import Firebase
import FSCalendar

class RegisterVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    // MARK: outlets and variables
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {

        dispatchGroup.enter()

        ref.child("staffSchedule").child(Auth.auth().currentUser!.uid).child("\(Calendar.current.component(.month, from: self.date))-\(Calendar.current.component(.year, from: self.date))").setValue([
            "selected": selectedDay
        ])
        
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main){
            self.dismiss(animated: true)
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    var blockedDay: [Int] = []
    var fulledDay: [String] = []
    var date = Date()
    var selectedDay: [Int] = []
    var ref: DatabaseReference!
    var dispatchGroup = DispatchGroup()

    
    
    //MARK: View
    override func viewDidLoad() {
        ref = Database.database().reference()
        setUpCalendar()
    }
    
    
    func setUpCalendar() {
        calendar.allowsMultipleSelection = true
        calendar.setCurrentPage(date, animated: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        label.text = "Register your working days for: \(month)-\(year)"
        for day in selectedDay{
            calendar.select(formatter.date(from: "\(day)/\(month)/\(year)"))
        }
    }
    
    
    
    
    
    //MARK: process blocked days
    //disable selection for blocked days
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if blockedDay.firstIndex(of: Calendar.current.component(.day, from: date)) != nil{
            return false
        }
        
        return true
    }
    
    //fill blocked days's color
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if blockedDay.firstIndex(of: Calendar.current.component(.day, from: date)) != nil{
            if Calendar.current.component(.month, from: date) == Calendar.current.component(.month, from: self.date){
                return .gray
            }
        }
        
        return .white
    }
    
    //hide title for blocked days
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        if blockedDay.firstIndex(of: Calendar.current.component(.day, from: date)) != nil {
            if Calendar.current.component(.month, from: date) == Calendar.current.component(.month, from: self.date){
                return ""
            }
        }
        
        return nil
    }
    
    
    
    
    
    //MARK: handle day seleting
    //when a day is being tapped (select), append to list of selected days
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if selectedDay.firstIndex(of: Calendar.current.component(.day, from: date)) == nil {
            selectedDay.append(Calendar.current.component(.day, from: date))
        }
    }
    
    //when a day is being re-tapped (deselect), remove that day from list of selected days
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let index = selectedDay.firstIndex(of: Calendar.current.component(.day, from: date)){
            selectedDay.remove(at: index)
        }
    }

    
    
    
    
    //MARK: prevent calendar's current page being changed
    func minimumDate(for calendar: FSCalendar) -> Date {
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        let dateString = "01/\(month)/\(year)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: dateString)!
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        let dateString = String(maxDayOfMonth(month: month, year: year)) + "/\(month)/\(year)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: dateString)!
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
