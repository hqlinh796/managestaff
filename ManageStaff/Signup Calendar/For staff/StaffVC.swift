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

    @IBOutlet weak var table: UITableView!
    var list: [String] = []
    var dispatchGroup = DispatchGroup()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = list[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
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
