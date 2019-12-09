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
    
    @IBOutlet weak var table: UITableView!
    
    //list of created calendar
    var list: [String] = []
    
    var dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        dispatchGroup.enter()
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
            self.table.reloadData()
        }
                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddCalendarView" {
            let destination = segue.destination as! AddCalendarVC
            destination.delegate = self
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
}
