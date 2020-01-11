//
//  ManageUserVC.swift
//  ManageStaff
//
//  Created by administrator on 1/9/20.
//  Copyright © 2020 linh. All rights reserved.
//

import UIKit
import Firebase

class ManageUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource, notifBackDelegate {
   
    
    
    @IBOutlet weak var searchBarStaff: UISearchBar!
    @IBOutlet weak var tableStaff: UITableView!
    @IBOutlet weak var buttonIsIncrease: UIButton!
    
    
    var ref : DatabaseReference!
    var arrayStaff = [user]()
    
    //var isSearch = false
    var arrayForSearch = [user]()
    var rowSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        loadUserToArray();
    }
    
    
    
    //--------ACTION
    
    @IBAction func tapOnSort(_ sender: Any) {
        let alert = UIAlertController(title: "Sắp xếp", message: "", preferredStyle: .actionSheet)
        let nameAction = UIAlertAction(title: "Theo tên", style: .default) { (UIAlertAction) in
            //sort by name
            self.arrayForSearch = self.arrayForSearch.sorted(by: { (user1, user2) -> Bool in
                if !self.buttonIsIncrease.isSelected{
                    return user1.firstname.lowercased() < user2.firstname.lowercased()
                }else{
                    return user1.firstname.lowercased() > user2.firstname.lowercased()
                }
                
            })
            self.tableStaff.reloadData()
        }
        let roleAction = UIAlertAction(title: "Theo chức vụ", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //sort by role
            self.arrayForSearch = self.arrayForSearch.sorted(by: { (user1, user2) -> Bool in
                if !self.buttonIsIncrease.isSelected{
                    return user1.role.lowercased() < user2.role.lowercased()
                }else{
                    return user1.role.lowercased() > user2.role.lowercased()
                }
            })
            self.tableStaff.reloadData()
        }
        let departmentAction = UIAlertAction(title: "Theo phòng ban", style: .default) { (UIAlertAction) in
            //sort by department
            self.arrayForSearch = self.arrayForSearch.sorted(by: { (user1, user2) -> Bool in
                if !self.buttonIsIncrease.isSelected{
                    return user1.department.lowercased() < user2.department.lowercased()
                }else{
                    return user1.department.lowercased() > user2.department.lowercased()
                }
                
            })
            self.tableStaff.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Hủy bỏ", style: .cancel, handler: nil)
        alert.addAction(roleAction)
        alert.addAction(nameAction)
        alert.addAction(departmentAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func buttonIsIncrease(_ sender: Any) {
        if self.buttonIsIncrease.isSelected{
            buttonIsIncrease.isSelected = false
        }else{
            buttonIsIncrease.isSelected = true
        }
    }
    
    
    
    func loadUserToArray(){
        ref.child("users").observe(.value) { (listStaff) in
            if listStaff.childrenCount > 0{
                self.arrayStaff.removeAll()
                for staff in listStaff.children.allObjects as! [DataSnapshot]{
                    let value = staff.value as! [String: AnyObject]
                    let newStaff = user()
                    newStaff.lastname = (value["lastname"] as? String)!
                    newStaff.firstname = (value["firstname"] as? String)!
                    newStaff.phone = (value["phone"] as? String)!
                    newStaff.image = (value["imgurl"] as! String)
                    newStaff.role = (value["role"] as? String)!
                    newStaff.department = (value["department"] as? String)!
                    newStaff.uid = staff.key
                    self.arrayStaff.append(newStaff)
                }
                self.arrayForSearch.removeAll()
                self.arrayForSearch = self.arrayStaff
                self.tableStaff.reloadData()
            }else{
                self.showNotif(title: "Lỗi", mes: "Không có dữ liệu nhân viên")
            }
        }
    }
    
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // ------- FUNCTION HELPER
    
    func downloadImage(from url: URL, imageView: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    

    
    //-------- EXTENSION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return isSearch ? arrayForSearch.count : arrayStaff.count
        return arrayForSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staffCell", for: indexPath) as! ManageUserCell
        var newStaff = user()
        newStaff = arrayForSearch[indexPath.row]
        
        let firstname = newStaff.firstname
        let lastname = newStaff.lastname
        cell.labelName.text = "\(lastname) \(firstname)"
        cell.labelPhone.text = newStaff.phone
        cell.labelRole.text = newStaff.role
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1).cgColor
        //cell.layer.cornerRadius =
        let url = URL(string: newStaff.image)
        downloadImage(from: url!, imageView: cell.imageviewAvatar)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let EditUserVC = storyboard?.instantiateViewController(withIdentifier: "editUserID") as! EditUserVC
        rowSelected = indexPath.row
        var uid = ""
       
        uid = arrayForSearch[rowSelected].uid
        EditUserVC.uid = uid
        EditUserVC.delegate = self
        present(EditUserVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    func reloadTable() {
        let indexPath = IndexPath.init(row: rowSelected, section: 0)
        tableStaff.reloadRows(at: [indexPath], with: .none)
    }
    
    
    
    
}


extension ManageUserVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            self.arrayForSearch = self.arrayStaff
        }else{
            arrayForSearch.removeAll()
            for user in arrayStaff{
                let fullName = "\(user.lastname) \(user.firstname)"
                if fullName.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)){
                    arrayForSearch.append(user)
                }
            }
            
        }
        tableStaff.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}
