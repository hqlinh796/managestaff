//
//  EditUserVC.swift
//  ManageStaff
//
//  Created by administrator on 1/10/20.
//  Copyright © 2020 linh. All rights reserved.
//

import UIKit
import Firebase

class EditUserVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var imageviewAvatarUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelSex: UILabel!
    @IBOutlet weak var textfieldRole: UITextField!
    @IBOutlet weak var textfieldDepartment: UITextField!

    let pickerviewRole = UIPickerView()
    let pickerviewDepartment = UIPickerView()
    var ref: DatabaseReference!
    var uid = ""
    let arrayDepartment = ["Giám đốc", "Nhân sự", "Kỹ thuật", "Kế toán", "Hậu cần"]
    let arrayRole = ["Nhân viên", "Trưởng phòng", "Phó phòng", "Giám đốc"]
    var delegate: notifBackDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ref = Database.database().reference()
        setup()
        loadUser(uid: uid)
    }
    
    
    
    @IBAction func tapOnSave(_ sender: Any) {
        ref.child("users").child(uid).updateChildValues([
            "role": textfieldRole.text!,
            "department": textfieldDepartment.text!]) { (Error, DatabaseReference) in
                if let error = Error{
                    self.showNotif(title: "Lỗi", mes: "Không thể cập nhật, hãy thử lại")
                    return
                }else{
                    let ManageUserVC = self.storyboard?.instantiateViewController(withIdentifier: "manageUserID") as! ManageUserVC
                    self.delegate?.reloadTable()
                    self.dismiss(animated: true, completion: nil)
                }
        }
    }
    
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setup(){
        
        //SETUP for picker
        pickerviewRole.dataSource = self
        pickerviewRole.delegate = self
        pickerviewDepartment.dataSource = self
        pickerviewDepartment.delegate = self
        
        //ToolBar Role
        let toolbarRole = UIToolbar();
        toolbarRole.sizeToFit()
        
        //done button & cancel button
        let doneButton1 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickerRole))
        let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton1 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPickerRole))
        toolbarRole.setItems([doneButton1, spaceButton1, cancelButton1], animated: false)
        // add toolbar to textField
        textfieldRole.inputAccessoryView = toolbarRole
        // add pickerviewSex to textField
        textfieldRole.inputView = pickerviewRole
        
        
        //ToolBar Department
        let toolbarDepartment = UIToolbar();
        toolbarDepartment.sizeToFit()
        
        //done button & cancel button
        let doneButton2 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickerDepartment))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton2 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPickerDepartment))
        toolbarDepartment.setItems([doneButton2, spaceButton2, cancelButton2], animated: false)
        // add toolbar to textField
        textfieldDepartment.inputAccessoryView = toolbarDepartment
        // add pickerviewSex to textField
        textfieldDepartment.inputView = pickerviewDepartment
        
        
        //SETUP FOR Avatar
        imageviewAvatarUser.layer.cornerRadius = imageviewAvatarUser.frame.width/2
        imageviewAvatarUser.clipsToBounds = true
        imageviewAvatarUser.layer.borderWidth = 4
        imageviewAvatarUser.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 224/255, alpha: 1).cgColor
        
        
    }
    
    @objc func donePickerRole(){
        textfieldRole.text = arrayRole[pickerviewRole.selectedRow(inComponent: 0)]
        view.endEditing(true)
    }
    
    @objc func cancelPickerRole(){
        view.endEditing(true)
    }
    
    @objc func donePickerDepartment(){
        textfieldDepartment.text = arrayDepartment[pickerviewDepartment.selectedRow(inComponent: 0)]
        view.endEditing(true)
    }
    
    @objc func cancelPickerDepartment(){
        view.endEditing(true)
    }
    
    
    func loadUser(uid: String){
        ref.child("users").child(uid).observe(.value) { (DataSnapshot) in
            if DataSnapshot.exists(){
                let value = DataSnapshot.value as! NSDictionary
                let firstname = value["firstname"] as? String ?? ""
                let lastname = value["lastname"] as? String ?? ""
                self.labelName.text = "\(lastname) \(firstname)"
                self.labelEmail.text = value["email"] as? String ?? ""
                self.labelSex.text = value["sex"] as? String ?? ""
                self.labelPhone.text = value["phone"] as? String ?? ""
                self.textfieldRole.text = value["role"] as? String ?? ""
                self.textfieldDepartment.text = value["department"] as? String ?? ""
                let imgurl = value["imgurl"] as? String ?? ""
                self.downloadImage(from: URL(string: imgurl)!, imageView: self.imageviewAvatarUser)
                
            }else{
                //show error
                self.showNotif(title: "Lỗi", mes: "Không thể load thông tin nhân viên")
            }
        }
    }
    
    
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
    
    
    
    //--------PROTOCOL
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerviewRole {
            return arrayRole.count
        }
        return arrayDepartment.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerviewRole {
            return arrayRole[row]
        }
        return arrayDepartment[row]
    }
    

}

protocol notifBackDelegate {
    func reloadTable()
}
