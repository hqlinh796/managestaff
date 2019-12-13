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
    var dispatchGroup = DispatchGroup()
    
    
    
    
    //MARK: View
    override func viewDidLoad() {
        //fetch all available calendar
        dispatchGroup.enter()
        let child = SpinnerViewController()
        startLoading(child: child)
        let db = Firestore.firestore()
        db.collection("calendar").getDocuments { (document, error) in
            if let err = error {
                print("error: \(err)")
                return
            }
            for month in document!.documents {
                self.list.append(month.documentID)
            }
            self.dispatchGroup.leave()
        }
        
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
        dispatchGroup.enter()
        let child = SpinnerViewController()
        startLoading(child: child)
        let db = Firestore.firestore()
        db.collection("calendar").document(list[indexPath.row]).getDocument(completion: {(document, error) in
            
            if let err = error {
                print("error:\(err)")
                return
            }
            
            let data = document?.data()
            self.blockedDay = data!["blocked day"] as! [Int]
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyy"
            let token = self.list[indexPath.row].split(separator: "-")
            self.date = formatter.date(from: "01/\(token[0])/\(token[1])")!
            self.stopLoading(child: child)
            self.performSegue(withIdentifier: "Detail", sender: self)
        }
        
    }
    
    
    
    
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
}
