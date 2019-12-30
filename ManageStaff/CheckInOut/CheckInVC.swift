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
            showNotif(notif: "Can't scan QR Code")
            return
        }
        textfiledQRCode.text = qrcode
        //find staff
        let child = SpinnerViewController()
        self.startLoading(child: child)
        findStaff(qrcode: qrcode)
        self.stopLoading(child: child)
    }
    
    @IBOutlet weak var labelNotif: UILabel!
    var ref : DatabaseReference!
    var currentYear : String?
    var currentMonth: String?
    var currentDay: String?
   
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var textfiledQRCode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelNotif.isHidden = true
        //get current Date
        getDate()
        
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
        labelNotif.isHidden = false
    }
    @IBAction func tapOnScan(_ sender: Any) {
        labelNotif.isHidden = true
      
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
    
    func findStaff(qrcode: String){
        ref.child("users").child(qrcode).observe(.value) { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            self.labelName.text = value?["name"] as? String
            self.labelPhone.text = value?["phone"] as? String
        }
    }
    
    func showNotif(notif: String){
        labelNotif.text = notif
        labelNotif.isHidden = false
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

}
