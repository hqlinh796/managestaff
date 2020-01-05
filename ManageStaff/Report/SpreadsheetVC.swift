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
    
    
    var listIDStaff = [String]()
    var listNameStaff = [String]()
    var ref = DatabaseReference()
    
    var sortBy = "firstname"
    var isDesc = false
    var filterBy = filter()
    var rowSort = 0
    var staff = user()
    let formatter = DateFormatter()
    var shiftLeader: [String: String] = [:]
    var isSearch = false
    var attendanceIndexPath = [IndexPath]()
    var searchBarActive = false
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonExport: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        loadUser { (listID, listName) in
            self.listIDStaff = listID
            self.listNameStaff = listName
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
        //self.filterBy = filter()
        AdvancedVC.delegate = self
        present(AdvancedVC, animated: true, completion: nil)
    }
    
    
    @IBAction func tapOnExport(_ sender: Any) {
        if listIDStaff.count == 0 {
            let alert = UIAlertController(title: "Lỗi", message: "Không có nhân viên trong danh sách", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(OKAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        let fileName = "Report \(filterBy.month)-\(filterBy.year).csv"
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        var header = "Họ tên"
        let numDay = getNumDayInMonth(month: filterBy.month, year: filterBy.year)
        for i in 1...numDay {
            header = header + "," + String(i)
        }
        
        var contentOfCSV = header + "\n"
        var section = 1
        let myGroup = DispatchGroup()
        loadReport(numDay: numDay, myGroup: myGroup)
        myGroup.notify(queue: .main){
            for name in self.listNameStaff {
                contentOfCSV = contentOfCSV + name
                for row in 1...numDay{
                    let indexPathTemp = IndexPath.init(row: row, section: section)
                    //var isExist = false
                    
                    if self.attendanceIndexPath.contains(indexPathTemp) {
                        contentOfCSV = contentOfCSV + ",X"
                        //isExist = true
                        
                        
                    }else{
                        contentOfCSV =  contentOfCSV + ",\"\""
                    }
                }
                contentOfCSV = contentOfCSV + "\n"
                section += 1
            }
            do {
                try contentOfCSV.write(to: filePath, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("Failed to create file")
                print("\(error)")
            }
            
            let activity = UIActivityViewController(activityItems: [ filePath], applicationActivities: nil)
            activity.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            activity.popoverPresentationController?.sourceView = self.view
            self.present(activity, animated: true)
            
        }
        
    }
    
  
    
    //Extension
    
    
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
        labelTime.text = "Điểm danh " + filterBy.month + "/" + filterBy.year
        listIDStaff.removeAll()
        listNameStaff.removeAll()
        //attendanceIndexPath.removeAll()
        loadUser { (listID, listName) in
            self.listIDStaff = listID
            self.listNameStaff = listName
            self.collectionView.reloadData()
        }
        
        
    }
    
    
    // Function helper
    
    
    func setup(){
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss dd-MM-yyyy"
        
        ref = Database.database().reference()
        //load user id and name to listUsers
        getDate()
        self.searchBar.delegate = self
        buttonExport.layer.cornerRadius = buttonExport.frame.width/2
        buttonExport.clipsToBounds = true
        
       
        //self.dismissKeyboard()
        
        searchBar.layer.cornerRadius = searchBar.frame.height/2.2
        searchBar.clipsToBounds = true
    }
    
   
    
    func loadReport(numDay: Int, myGroup: DispatchGroup){
        attendanceIndexPath.removeAll()
        for section in 1...listIDStaff.count{
            for row in 1...numDay{
                let day = row<10 ? "0" + String(row) : String(row)
                let key = filterBy.year + filterBy.month + day + listIDStaff[section-1]
                myGroup.enter()
                ref.child("attendance").child(key).observeSingleEvent(of: .value) { (DataSnapshot) in
                    if !DataSnapshot.exists(){
                        let indexPathTemp = IndexPath.init(row: row, section: section)
                        self.attendanceIndexPath.append(indexPathTemp)
                    }
                    myGroup.leave()
                }
            }
        }
        
    }
    
    func loadUser(completion: @escaping (_ listIDStaff: [String], _ listNameStaff: [String])->()){
        self.ref.child("users").queryOrdered(byChild: sortBy).observeSingleEvent(of: .value) { (Snapshot) in
            if Snapshot.childrenCount>0{
                var listID = [String]()
                var listName = [String]()
                for dataSnapshot in Snapshot.children.allObjects as! [DataSnapshot]{
                    if let user = dataSnapshot.value as? [String: Any]{
                        let lastname = user["lastname"] as! String
                        let firstname = user["firstname"] as! String
                        let name = lastname + " " + firstname
                        if self.isValidUser(user: user, name: name){
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
    
    func getNumDayInMonth(month: String, year: String) -> Int{
        switch Int(month) {
        case 4, 6, 9, 11:
            return 30
        case 2:
            if Int(year)! % 4 == 0 {
                return 29
            }else{
                return 28
            }
        default:
            return 31
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
            filterBy.month = currentMonth == 1 ? String(12) : String(currentMonth - 1)
            filterBy.year = currentMonth == 1 ? String(currentYear-1) : String(currentYear)
            labelTime.text = "Điểm danh " + filterBy.month + "/" + filterBy.year
        }
    }
    
    func isValidUser(user: [String: Any], name: String) -> Bool{
        //let userResult: [String: String]?
        
        if isSearch {
            let keyword = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let regexText = "[a-z]*" + keyword + "[a-z]*"
            let regex = try! NSRegularExpression(pattern: regexText, options: .caseInsensitive)
            let range = NSRange(location: 0, length: name.utf16.count)
            if (regex.firstMatch(in: name, options: [], range: range) == nil){
                return false
            }
        }
        
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}





// MARK: - UICollectionViewDataSource
extension SpreadsheetVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listIDStaff.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier", for: indexPath) as! ContentCollectionViewCell
        
        let numDayInMonth = getNumDayInMonth(month: filterBy.month, year: filterBy.year)
        
        if indexPath.section % 2 != 0 {
            cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if indexPath.section == 0 {
            cell.backgroundColor = UIColor(red: 255/255, green: 126/255, blue: 64/255, alpha: 1)
            cell.contentLabel.textColor = .white
            cell.contentLabel.font = UIFont.boldSystemFont(ofSize: 19)
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
                cell.contentLabel.text = listNameStaff[indexPath.section-1]
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
                let key = filterBy.year + filterBy.month + day + listIDStaff[indexPath.section - 1]
                ref.child("attendance").child(key).observeSingleEvent(of: .value) { (DataSnapshot) in
                    if !DataSnapshot.exists(){
                        value = "X"
                        //self.attendanceIndexPath.append(indexPath)
                    }
                    cell.contentLabel.text = value
                }
            }
            cell.contentLabel.textColor = .black
            cell.contentLabel.font = UIFont.systemFont(ofSize: 15)
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension SpreadsheetVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        if indexPath.section != 0 {
            if indexPath.row == 0 {
                //show info
                // Get user value
                let uid = listIDStaff[indexPath.section - 1]
                ref.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    self.staff.email = value?["email"] as? String ?? ""
                    self.staff.firstname = value?["firstname"] as? String ?? ""
                    self.staff.phone = value?["phone"] as? String ?? ""
                    self.staff.role = value?["role"] as? String ?? ""
                    self.staff.sex = value?["sex"] as? String ?? ""
                    self.staff.lastname = value?["lastname"] as? String ?? ""
                    self.staff.image = value?["imgurl"] as? String ?? ""
                    self.staff.department = value?["department"] as? String ?? ""
                    self.staff.uid = uid
                    print("SHOW")
                    //show Popup view
                    let popUpStaffVC = self.storyboard?.instantiateViewController(withIdentifier: "PopUpStaffID") as! PopUpStaffVC
                    popUpStaffVC.staff = self.staff
                    self.present(popUpStaffVC, animated: true, completion: nil)
                }
            }else{
                //show time
                let year = filterBy.year;
                let month = filterBy.month.count == 1 ? "0" + filterBy.month : filterBy.month
                let day = indexPath.row < 10 ? "0" + String(indexPath.row) : String(indexPath.row)
                let uid = listIDStaff[indexPath.section - 1]
                let key = year + month + day + uid
                ref.child("attendance").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists(){
                        let value = snapshot.value as! NSDictionary
                        let name = self.listNameStaff[indexPath.section - 1]
                        let time = value["time"] as! TimeInterval
                        let date = NSDate(timeIntervalSince1970: time)
                        let dateString = self.formatter.string(from: date as Date)
                        let shiftleaderid = value["shiftleaderid"] as! String
                        if let shiftLeaderName = self.shiftLeader[shiftleaderid] {
                            let popUpAttendanceVC = self.storyboard?.instantiateViewController(withIdentifier: "PopUpAttendanceID") as! PopUpAtttendanceVC
                            popUpAttendanceVC.name = name
                            popUpAttendanceVC.time = dateString
                            popUpAttendanceVC.shiftLeader = shiftLeaderName
                            self.present(popUpAttendanceVC, animated: true, completion: nil)
                            
                        }else{
                            //appende to dictionary shift leader
                            self.ref.child("users").child(shiftleaderid).observeSingleEvent(of: .value, with: { (DataSnapshot) in
                                if DataSnapshot.exists(){
                                    let value2 = DataSnapshot.value as! NSDictionary
                                    let firstname2 = value2["firstname"] as! String
                                    let lastname2 = value2["lastname"] as! String
                                    let shiftLeaderName = lastname2 + " " + firstname2
                                    self.shiftLeader.updateValue(shiftLeaderName, forKey: shiftleaderid)
                                    
                                    let popUpAttendanceVC = self.storyboard?.instantiateViewController(withIdentifier: "PopUpAttendanceID") as! PopUpAtttendanceVC
                                    popUpAttendanceVC.name = name
                                    popUpAttendanceVC.time = dateString
                                    popUpAttendanceVC.shiftLeader = shiftLeaderName
                                    self.present(popUpAttendanceVC, animated: true, completion: nil)
                                }
                            })
                        }
                    }
                    
                }) { (error) in
                    print("Can't load user info")
                }
            }
        }
    }
    
}

extension SpreadsheetVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            isSearch = false
        }
        
        listIDStaff.removeAll()
        listNameStaff.removeAll()
        // attendanceIndexPath.removeAll()
        loadUser { (listID, listName) in
            self.listNameStaff = listName
            self.listIDStaff = listID
            self.isSearch = true
            self.collectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}
