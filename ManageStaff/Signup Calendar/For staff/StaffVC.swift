//
//  StaffVC.swift
//  ManageStaff
//
//  Created by Hung on 12/9/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import Firebase

class StaffVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    

    //MARK: outlets and variables
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var table: UITableView!
    var list: [String] = []
    var blockedDay: [Int] = []
    var date = Date()
    // for async-await
    var dispatchQueue = DispatchQueue(label: "Queue")
    var dispatch = DispatchSemaphore(value: 0)
    var dispatchGroup = DispatchGroup()
    var ref: DatabaseReference!
    
    
    
    
    //MARK: View
    override func viewDidLoad() {
        ref = Database.database().reference()
        
        //fetch all available calendar
        dispatchGroup.enter()
        let child = SpinnerViewController()
        startLoading(child: child)
        ref.child("schedule").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            for month in value.allKeys{
                self.list.append(month as! String)
            }
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            self.stopLoading(child: child)
            self.table.reloadData()
        }
    }
    
    
    
    
    //MARK: for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let child = SpinnerViewController()
        startLoading(child: child)
        
        getBlocked(row: indexPath.row) {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyy"
            let token = self.list[indexPath.row].split(separator: "-")
           self.date = formatter.date(from: "01/\(token[0])/\(token[1])")!
           self.stopLoading(child: child)
           self.performSegue(withIdentifier: "Detail", sender: self)
        }
    }
    
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
    
//    func getSelected(row: Int, completion: @escaping ()->()){
//        dispatchGroup.enter()
//
//        ref.child("staffSchedule").child(Auth.auth().currentUser!.uid).child(self.list[row]).observeSingleEvent(of: .value, with: { (snapshot) in
//            let data = snapshot.value as! NSDictionary
//            let days = data.allKeys
//
//            for day in days {
//                self.dispatchGroup.enter()
//                self.selectedDay.append(Int(day as! String)!)
//                self.dispatchGroup.leave()
//            }
//
//            self.dispatchGroup.leave()
//        })
//
//        dispatchGroup.notify(queue: .main){
//            print(self.selectedDay)
//            completion()
//        }
//    }
    
    
    
    
    //MARK: Send date and list of blocked days to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let destination = segue.destination as! RegisterVC
            destination.blockedDay = blockedDay
            destination.date = date
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
