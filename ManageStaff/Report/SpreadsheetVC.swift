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

class SpreadsheetVC: UIViewController {
    
    let contentCellIdentifier = "ContentCellIdentifier"
    var listID = [String]()
    var listName = [String]()
    var ref = DatabaseReference()
    var year = ""
    var month = ""
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //load user id and name to listUsers
        getDate()
        loadUser { (listID, listName) in
            self.listID = listID
            self.listName = listName
            self.collectionView.dataSource = self
        }
        
        
        
        
    }
    
    
    func loadUser(completion: @escaping (_ listID: [String], _ listName: [String])->()){
        self.ref.child("users").observeSingleEvent(of: .value) { (Snapshot) in
            if Snapshot.childrenCount>0{
                var listID = [String]()
                var listName = [String]()
                for dataSnapshot in Snapshot.children.allObjects as! [DataSnapshot]{
                    if let user = dataSnapshot.value as? [String: String]{
                        let id = dataSnapshot.key
                        let name = user["name"] as? String
                        listID.append(id)
                        listName.append(name!)
                    }
                }
                completion(listID, listName)
            }
        }
    }
    func getDate(){
        //get year and month
        year = "2019"
        month = "12"
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                      for: indexPath) as! ContentCollectionViewCell
        
        if indexPath.section % 2 != 0 {
            cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.contentLabel.text = "Tên"
            } else {
                cell.contentLabel.text = String(indexPath.row)
            }
        } else {
            if indexPath.row == 0 {
                //tên nhân viên
                cell.contentLabel.text = listName[indexPath.section-1]
            } else {
                //vắng / không
                var day = String(indexPath.row)
                if day.count == 1{
                    day = "0" + day
                }
                var value = ""
                let key = year + month + day + listID[indexPath.section-1]
                ref.child("checkin").child(key).observeSingleEvent(of: .value) { (DataSnapshot) in
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
    
}
