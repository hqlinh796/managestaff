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
    
    
    
    
    //MARK: View
    override func viewDidLoad() {
        dispatchGroup.enter()
        let child = SpinnerViewController()
        startLoading(child: child)
        let db = Firestore.firestore()
        
        db.collection("calendar").getDocuments(completion: {(document, error) in
            if let err = error{
                print("error: \(err)")
                return
            }
            
            for data in document!.documents {
                self.list.append(data.documentID)
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
        let child = SpinnerViewController()
        startLoading(child: child)
        let db = Firestore.firestore()
        db.collection("calendar").document(list[indexPath.row]).getDocument(completion: {(document, error) in
            if let err = error {
                print("error: \(err)")
                return
            }
            let data = document?.data()
            self.blockedDay = data!["blocked day"] as! [Int]
            self.stopLoading(child: child)
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            let token = self.list[indexPath.row].split(separator: "-")
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            self.date = formatter.date(from: "1/\(token[0])/\(token[1])")!
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
    
}
