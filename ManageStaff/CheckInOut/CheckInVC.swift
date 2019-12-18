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
            showError(error: "Can't scan QR Code")
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
    var currentDate: String?
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var textfiledQRCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelError.isHidden = true
        labelNotif.isHidden = true
        //get current Year and Month
        let calendar = Calendar.current
        let date = Date()
        currentYear = String(calendar.component(.year, from: date))
        currentMonth = String(calendar.component(.month, from: date))
        currentDate = String(calendar.component(.day, from: date))
        
        ref = Database.database().reference()
    }
    
    @IBAction func tapOnSave(_ sender: Any) {
        //validate before save
        print("SAVE----------")
        let arrayName = ["Linh", "Na"]
        //save user in check-in list
        let childYear = "Year " + currentYear!
        let childMonth = "Month " + currentMonth!
       ref.child("checkin").child(childYear).child(childMonth).child("123").updateChildValues(<#T##values: [AnyHashable : Any]##[AnyHashable : Any]#>)
        labelNotif.isHidden = false
    }
    @IBAction func tapOnScan(_ sender: Any) {
        labelNotif.isHidden = true
        labelError.isHidden = true
        let ScanQRVC = storyboard?.instantiateViewController(withIdentifier: "ScanQRID") as! ScanQRVC
        ScanQRVC.delegate = self
        self.present(ScanQRVC, animated: false, completion: nil)
    }
    
    func findStaff(qrcode: String){
        ref.child("users").child(qrcode).observe(.value) { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            self.labelName.text = value?["name"] as? String
            self.labelPhone.text = value?["phone"] as? String
        }
    }
    
    func showError(error: String){
        labelError.text = error
        labelError.isHidden = false
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
