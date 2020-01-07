//
//  ManagerVC.swift
//  ManageStaff
//
//  Created by Hung on 12/8/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import Firebase

class ManagerVC: UIViewController, UITableViewDelegate, UITableViewDataSource, AddCalendarDelegate{

    

    //MARK: outlets and variables
    @IBOutlet weak var table: UITableView!
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    //list of created calendar
    var list: [String] = []
    var blockedDay: [Int] = []
    var dispatchGroup = DispatchGroup()
    var date = Date()
    var ref: DatabaseReference!
    var days:[[String: Int]] = [[:]]

    
    
    
    //MARK: View
    override func viewDidAppear(_ animated: Bool) {

        list = []
        blockedDay = []
        ref = Database.database().reference()
        
        dispatchGroup.enter()
        let child = SpinnerViewController()
        startLoading(child: child)
  
        ref.child("schedule").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            if value != nil {
                for name in value!.allKeys {
                    self.list.append(name as! String)
                }
            }
            
            self.dispatchGroup.leave()
        })


        dispatchGroup.notify(queue: .main) {
            self.stopLoading(child: child)
            self.table.reloadData()
        }
                
    }
    
    
    
    
    //MARK: Send data and set delegate to get data back from next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //in add-new-calendar mode
        if segue.identifier == "CreateCalendar" {
            let destination = segue.destination as! AddCalendarVC
            destination.delegate = self
            destination.mode = "creating"
            destination.date = date
        }
        
        //in update-calendar mode
        if segue.identifier == "UpdateCalendar"{
            let destination = segue.destination as! AddCalendarVC
            destination.delegate = self
            destination.blockedDay = blockedDay
            destination.mode = "updating"
            destination.date = date
        }
    }
    
    //delegate to get data from Add-new-calendar view
    func AddCalendar(month: Int, year: Int) {
        if list.firstIndex(of: "\(month)-\(year)") != nil{
            dismiss(animated: true)
        } else {
            list.append("\(month)-\(year)")
            dismiss(animated: true)
            table.reloadData()
        }
    }
    
    
    
    
    
    //MARK: for table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dispatchGroup.enter()
        let token = self.list[indexPath.row].split(separator: "-")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.date = formatter.date(from: "1/\(token[0])/\(token[1])")!
        let child = SpinnerViewController()
        startLoading(child: child)
        
        self.ref.child("schedule").child(list[indexPath.row]).observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? NSDictionary
            
            if data != nil {
                self.blockedDay = data!["blocked day"] as! [Int]
            }
            self.dispatchGroup.leave()
        })
        

        dispatchGroup.notify(queue: .main) {
            self.stopLoading(child: child)
            self.performSegue(withIdentifier: "UpdateCalendar", sender: self)
        }
                
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
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
