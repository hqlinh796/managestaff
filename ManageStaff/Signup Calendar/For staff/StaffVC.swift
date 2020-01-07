//
//  StaffVC.swift
//  ManageStaff
//
//  Created by Hung on 12/9/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import Firebase
import EventKit

class StaffVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    

    //MARK: outlets and variables
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reminder(_ sender: Any) {
        let alert = UIAlertController(title: "Reminder", message: "Tạo reminder cho các ngày đã đăng kí?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction!) in
            let child = SpinnerViewController()
            self.startLoading(child: child)
            self.dispatchGroup.enter()
            
            self.EKpermission()
            self.list = self.registeredList

            for (index, title) in self.registeredList.enumerated() {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyy HH:mm:ss"
                let token = title.split(separator: "-")
                self.selectedDay = []

                self.getSelected(row: index) {
                    
                    for day in self.selectedDay {
                        let reminder = EKReminder(eventStore: self.eventStore)

                        reminder.title = "Đi làm"
                        reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                        
                        let absoluteDate = formatter.date(from: "\(day)/\(token[0])/\(token[1]) 08:00:00")
                        let absoluteAlarm = EKAlarm(absoluteDate: absoluteDate!)
                        
                        reminder.addAlarm(absoluteAlarm)
                        reminder.notes = "Sự kiện này được tạo từ ứng dụng"
                        
                        self.dispatchGroup.enter()
                        do {
                            try self.eventStore.save(reminder, commit: true)
                        } catch let error {
                            print("Error \(error.localizedDescription)")
                        }
                        self.dispatchGroup.leave()
                    }
                }
            }
            
            self.dispatchGroup.leave()
            self.dispatchGroup.notify(queue: .main){
                self.stopLoading(child: child)
            }
        })
        
        alert.addAction(okAction)
        let cancel = UIAlertAction(title: "Huỷ", style: UIAlertAction.Style.cancel)
        alert.addAction(cancel)
        present(alert, animated: false, completion: nil)
    }
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var newTable: UITableView!
    
    var registeredList: [String] = []
    var newList: [String] = []
    var list: [String] = []
    
    var blockedDay: [Int] = []
    var selectedDay: [Int] = []
    
    var date = Date()
    
    // for async-await
    var dispatchGroup = DispatchGroup()
    var ref: DatabaseReference!
    var eventStore = EKEventStore()
    
    func EKpermission(){
        switch EKEventStore.authorizationStatus(for: .reminder) {
            case .authorized:
                return
            case .denied:
                print("Access denied")
                return
            case .notDetermined:
                eventStore.requestAccess(to: .reminder) { (granted, error) in
                    if !granted {
                        print("access not granted")
                        print(error?.localizedDescription ?? "Error")
                        return
                    } else {
                        print("Access granted")
                        return
                    }
                }
            default:
                print("Case default")
                return
        }
    }
    
    
    
    //MARK: View
    override func viewWillAppear(_ animated: Bool) {
        selectedDay = []
        blockedDay = []
        registeredList = []
        newList = []
        ref = Database.database().reference()
        
        
        let child = SpinnerViewController()
        startLoading(child: child)
     
        getRegistered {
            
            self.getNew {
                self.stopLoading(child: child)
                self.table.reloadData()
                self.newTable.reloadData()
            }
        }
    }

    // get already registered schedule
    func getRegistered(completion: @escaping ()->()){
        dispatchGroup.enter()
        
        ref.child("staffSchedule").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            if value != nil {
                for month in value!.allKeys {
                    self.registeredList.append(month as! String)
                }
            }
            
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main){
            completion()
        }
    }
    
    // get new schedule if there are any
    func getNew(completion: @escaping ()->()){
        dispatchGroup.enter()
        
        ref.child("schedule").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary

            if value != nil {
                for month in value!.allKeys {
                    if self.registeredList.firstIndex(of: month as! String) == nil {
                        self.newList.append(month as! String)
                    }
                }
            }
            
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main){
            completion()
        }
    }
    
    
    
    
    
    
    
    //MARK: for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        
        switch tableView {
        case table:
            count = registeredList.count
        case newTable:
            count = newList.count
        default:
            print("Bug at numberOfRows")
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch tableView {
        case table:
            cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = registeredList[indexPath.row]
        case newTable:
            cell = newTable.dequeueReusableCell(withIdentifier: "newCell", for: indexPath)
            cell.textLabel!.text = newList[indexPath.row]
        default:
            print("Bug at cellForRow")
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let child = SpinnerViewController()
        startLoading(child: child)
        
        if tableView == self.table {
            list = registeredList
            
            getBlocked(row: indexPath.row) {
                
                self.getSelected(row: indexPath.row) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyy"
                    let token = self.list[indexPath.row].split(separator: "-")
                    self.date = formatter.date(from: "01/\(token[0])/\(token[1])")!
                    
                    self.stopLoading(child: child)
                    self.performSegue(withIdentifier: "Detail", sender: self)
                }
            }
        } else {
            list = newList
            
            getBlocked(row: indexPath.row) {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyy"
                let token = self.list[indexPath.row].split(separator: "-")
                self.date = formatter.date(from: "01/\(token[0])/\(token[1])")!
                
                self.stopLoading(child: child)
                self.performSegue(withIdentifier: "Detail", sender: self)
            }
        }
    }
    
    
    
    // get blocked days
    func getBlocked(row: Int, completion: @escaping ()->()){
        dispatchGroup.enter()
        
        self.ref.child("schedule").child(self.list[row]).observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as! NSDictionary
            self.blockedDay = data["blocked day"] as! [Int]
            self.dispatchGroup.leave()
        })
            
        dispatchGroup.notify(queue: .main){
            completion()
        }
    }
    
    
    
    
    // get selected days from registered schedule
    func getSelected(row: Int, completion: @escaping ()->()){
        dispatchGroup.enter()

        ref.child("staffSchedule").child(Auth.auth().currentUser!.uid).child(self.list[row]).observeSingleEvent(of: .value, with: { (snapshot) in
 
            let data = snapshot.value as? NSDictionary
            self.selectedDay = data?["selected"] as! [Int]
            self.dispatchGroup.leave()
        })

        dispatchGroup.notify(queue: .main){
            completion()
        }
    }
    
    
    
    
    //MARK: Send date and list of blocked days to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let destination = segue.destination as! RegisterVC
            destination.blockedDay = blockedDay
            destination.date = date
            destination.selectedDay = selectedDay
        }
    }
    
    

    
    
    
    
    //MARK: Spinner
    func startLoading(child: SpinnerViewController){
        addChild(child)
        child.view.frame = view.frame
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func stopLoading(child: SpinnerViewController){
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
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
