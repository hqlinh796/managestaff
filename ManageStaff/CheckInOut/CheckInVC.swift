//
//  CheckInVC.swift
//  ManageStaff
//
//  Created by administrator on 11/28/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseFirestore

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
    

    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var textfiledQRCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelError.isHidden = true
    }
    
    @IBAction func tapOnSave(_ sender: Any) {
        //save user in check-in list
        
    }
    @IBAction func tapOnScan(_ sender: Any) {
        labelError.isHidden = true
        let ScanQRVC = storyboard?.instantiateViewController(withIdentifier: "ScanQRID") as! ScanQRVC
        ScanQRVC.delegate = self
        self.present(ScanQRVC, animated: false, completion: nil)
    }
    func findStaff(qrcode: String){
        let db = Firestore.firestore()
        db.collection("users").document(qrcode).getDocument { (document, error) in
            if let err = error{
                self.showError(error: "Can't find that ID")
                return
            }
            let data = document?.data()
            self.labelName.text = data!["name"] as? String
            self.labelPhone.text = data!["phone"] as? String
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
