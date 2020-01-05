//
//  CheckInVC.swift
//  ManageStaff
//
//  Created by administrator on 11/28/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import Firebase

class CheckInVC: UIViewController, scanQRCodeDelegate {
    func sendQRCode(qrcode: String) {
        if qrcode.isEmpty{
            showNotif(title: "Lỗi", mes: "Không thể nhận dạng QR CODE")
            return
        }
        textfiledQRCode.text = qrcode
        //find staff
        let child = SpinnerViewController()
        self.startLoading(child: child)
        getStaff(qrcode: qrcode)
        self.stopLoading(child: child)
        showNotif(title: "Thành công", mes: "Đã thêm \(labelName)")
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelLeaderShift: UILabel!
    @IBOutlet weak var imageviewAvatar: UIImageView!
   
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var textfiledQRCode: UITextField!
    @IBOutlet weak var labelSex: UILabel!
    @IBOutlet weak var labelDepartment: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var stackInfo: UIStackView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var buttonScan: UIButton!
    @IBOutlet weak var viewShiftLeader: UIView!
    @IBOutlet weak var imageShiftLeader: UIImageView!
    
    
    
    var ref : DatabaseReference!
    var currentYear : String?
    var currentMonth: String?
    var currentDay: String?
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDate()
        setup()
        
        ref = Database.database().reference()
       
    }
    
    @IBAction func tapOnSave(_ sender: Any) {
        //validate before save
        
        
        //save user in check-in list

        let key = currentYear! + currentMonth! + currentDay! + textfiledQRCode.text!
        ref.child("attendance").child(key).setValue([
        "staffid": textfiledQRCode.text!,
        "time": NSDate().timeIntervalSince1970,
        "shiftleaderid": userAccount.uid
    ])
        
    }
    @IBAction func tapOnScan(_ sender: Any) {
        
      
        let ScanQRVC = storyboard?.instantiateViewController(withIdentifier: "ScanQRID") as! ScanQRVC
        ScanQRVC.delegate = self
        self.present(ScanQRVC, animated: false, completion: nil)
    }
    
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getDate(){
        let calendar = Calendar.current
        let date = Date()
        currentYear = String(calendar.component(.year, from: date))
        currentMonth = String(calendar.component(.month, from: date))
        if currentMonth?.count == 1{
            currentMonth = "0" + currentMonth!
        }
        currentDay = String(calendar.component(.day, from: date))
        if currentDay?.count == 1{
            currentDay = "0" + currentDay!
        }
    }
    

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, imageView: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    func getStaff(qrcode: String){
        ref.child("users").child(qrcode).observe(.value) { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            
            let lastname = value?["lastname"] as? String
            let firstname = value?["firstname"] as? String
            self.labelName.text = lastname! + " " + firstname!
            self.labelPhone.text = value?["phone"] as? String
            let url = URL(string: value?["imgurl"] as! String)
            self.downloadImage(from: url!, imageView: self.imageviewAvatar)
            self.labelSex.text = value?["sex"] as? String
            self.labelDepartment.text = value?["department"] as? String
            self.labelRole.text = value?["role"] as? String
            let time = value?["time"] as! TimeInterval
            let date = NSDate(timeIntervalSince1970: time)
            let dateString = self.formatter.string(from: date as Date)
            self.labelTime.text = dateString
        }
    }
    
    func showNotif(title: String, mes: String){
        let alert = UIAlertController(title: title, message: mes, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    func startLoading(child: SpinnerViewController){
        addChild(child)
        child.view.frame = view.frame
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    //stop loading view
    func stopLoading(child: SpinnerViewController){
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    func setup(){
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss dd-MM-yyyy"
        //labelNotif.isHidden = true
        
        imageviewAvatar.layer.cornerRadius = imageviewAvatar.frame.width/2
        imageviewAvatar.clipsToBounds = true
        imageviewAvatar.layer.borderWidth = 2
        imageviewAvatar.layer.borderColor = UIColor(red: 36/255, green: 74/255, blue: 145/255, alpha: 1).cgColor
        labelTitle.text = "Điểm danh \(currentDay!)/\(currentMonth!)/\(currentYear!)"
        labelLeaderShift.text = "Trưởng ca: " + userAccount.lastname + " " + userAccount.firstname
        
        let constant = self.view.frame.width/4
        let leftEdgeOfStackInfo = NSLayoutConstraint(item: stackInfo, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewContent, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: constant)
        viewContent.addConstraint(leftEdgeOfStackInfo)
        buttonScan.layer.cornerRadius = 0
        
        //set up for image
        let url = URL(string: userAccount.image)!
        imageShiftLeader.image = imageAvatar
        imageShiftLeader.layer.cornerRadius = imageShiftLeader.frame.width/2
        imageShiftLeader.clipsToBounds = true
        imageShiftLeader.layer.borderColor = UIColor.white.cgColor
        imageShiftLeader.layer.borderWidth = 2
        
        //set up for view shiftleader
        viewShiftLeader.layer.cornerRadius = viewShiftLeader.frame.height / 2
        viewShiftLeader.clipsToBounds = true
        viewShiftLeader.layer.borderColor = UIColor.white.cgColor
        viewShiftLeader.layer.borderWidth = 4
        
    }
    
}



