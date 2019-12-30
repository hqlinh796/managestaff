// Copyright 2017 Brightec
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import FirebaseDatabase


class SpreadsheetVC: UIViewController, FilterAndSortDelegate{
    
    
    
    let contentCellIdentifier = "ContentCellIdentifier"
    var listID = [String]()
    var listName = [String]()
    var ref = DatabaseReference()
    var scrollView: UIScrollView!
    var sortBy = "firstname"
    var isDesc = false
    var filterBy = filter()
    var rowSort = 0
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        scrollView = UIScrollView()
        
        
        ref = Database.database().reference()
        //load user id and name to listUsers
        getDate()
        loadUser { (listID, listName) in
            self.listID = listID
            self.listName = listName
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOnAdvanced(_ sender: Any) {
        let AdvancedVC = storyboard?.instantiateViewController(withIdentifier: "AdvancedID") as! AdvancedVC
        
        AdvancedVC.rowSort = self.rowSort
        AdvancedVC.isDesc = self.isDesc
        AdvancedVC.filterBy = self.filterBy
        self.filterBy = filter()
        
        AdvancedVC.delegate = self
        present(AdvancedVC, animated: true, completion: nil)
    }
    
    func filterBy(filterBy: filter, sortBy: Int, isDesc: Bool) {
        self.filterBy = filterBy
        //print(self.filterBy.sex)
        if sortBy == 0 {
            self.sortBy = "firstname"
        }else if sortBy == 1{
            self.sortBy = "department"
        }else{
            self.sortBy = "role"
        }
        self.rowSort = sortBy
        self.isDesc = isDesc
        
        listID.removeAll()
        listName.removeAll()
        loadUser { (listID, listName) in
            self.listID = listID
            self.listName = listName
            self.collectionView.reloadData()
        }
        
        
    }
    
    
    
    func loadUser(completion: @escaping (_ listID: [String], _ listName: [String])->()){
        self.ref.child("users").queryOrdered(byChild: sortBy).observeSingleEvent(of: .value) { (Snapshot) in
            if Snapshot.childrenCount>0{
                var listID = [String]()
                var listName = [String]()
                for dataSnapshot in Snapshot.children.allObjects as! [DataSnapshot]{
                    if let user = dataSnapshot.value as? [String: Any]{
                        if self.isValidUser(user: user){
                            let lastname = user["lastname"] as! String
                            let firstname = user["firstname"] as! String
                            let name = lastname + " " + firstname
                            let id = dataSnapshot.key
                            listID.append(id)
                            listName.append(name)
                        }
                    }
                    
                }
                
                if self.isDesc {
                    completion(listID.reversed(), listName.reversed())
                }else{
                    completion(listID, listName)
                }
                
            }
        }
        
    }
   
    func getDate(){
        //get year and month
        if filterBy.year.isEmpty {
            //get current year and last month
            let calendar = Calendar.current
            let date = Date()
            let currentYear = calendar.component(.year, from: date)
            let currentMonth = calendar.component(.month, from: date)
            filterBy.year = String(currentYear)
            filterBy.month = String(currentMonth - 1)
        }
    }
    
    func isValidUser(user: [String: Any]) -> Bool{
        //let userResult: [String: String]?
        //var isExistUser = false
        if filterBy.sex.count == 1 && user["sex"] as! String != filterBy.sex[0] {
            return false
        }
        
        if (filterBy.department.count > 0 && filterBy.department.count < 5 && filterBy.department.firstIndex(of: user["department"] as! String) == nil){
           
            return false
        }
        if (filterBy.role.count > 0 && filterBy.role.count < 4 && filterBy.role.firstIndex(of: user["role"]! as! String) == nil){
            
            return false
        }
        return true
    }
    
}



// MARK: - UICollectionViewDataSource
extension SpreadsheetVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listID.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier", for: indexPath) as! ContentCollectionViewCell
        
        var numDayInMonth = 0
        switch Int(filterBy.month) {
        case 4, 6, 9, 11:
            numDayInMonth = 30
        case 2:
            if Int(filterBy.year)! % 4 == 0 {
                numDayInMonth = 29
            }else{
                numDayInMonth = 28
            }
        default:
            numDayInMonth = 31
        }
        
        if indexPath.section % 2 != 0 {
            cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.contentLabel.text = "Tên"
            }else if indexPath.row > numDayInMonth{
                cell.contentLabel.text = ""
                cell.backgroundColor = .white
            }
            else {
                cell.contentLabel.text = String(indexPath.row)
            }
        } else {
            if indexPath.row == 0 {
                //tên nhân viên
                cell.contentLabel.text = listName[indexPath.section-1]
                cell.contentLabel.textAlignment = .left
            }else if indexPath.row > numDayInMonth{
                cell.contentLabel.text = ""
                cell.backgroundColor = .white
            }else {
                //vắng / không
                var day = String(indexPath.row)
                if day.count == 1{
                    day = "0" + day
                }
                var value = ""
                let key = filterBy.year + filterBy.month + day + listID[indexPath.section-1]
                ref.child("attendance").child(key).observeSingleEvent(of: .value) { (DataSnapshot) in
                    if !DataSnapshot.exists(){
                        value = "X"
                    }
                    cell.contentLabel.text = value
                }
            }
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension SpreadsheetVC: UICollectionViewDelegate {
 
    /*
 let myTimeInterval = TimeInterval(timestamp)
 let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
 let formatter = DateFormatter()
 
 formatter.timeZone = TimeZone.current
 
 formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
 
 let dateString = formatter.string(from: time as Date)
 */
    
}
