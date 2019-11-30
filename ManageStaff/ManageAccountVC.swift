//
//  ManageAccountVC.swift
//  ManageStaff
//
//  Created by administrator on 11/29/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class ManageAccountVC: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var imageviewQRCode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userID!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.labelEmail.text = Auth.auth().currentUser?.email
                self.labelPhone.text = data!["phone"] as? String
                self.labelName.text = data!["name"] as? String
                // 1
                let myString = userID!
                // 2
                let data2 = myString.data(using: String.Encoding.ascii)
                // 3
                guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
                // 4
                qrFilter.setValue(data2, forKey: "inputMessage")
                // 5
                guard let qrImage = qrFilter.outputImage else { return }
                self.imageviewQRCode.image = UIImage(ciImage: qrImage)
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func tapOnSignOut(_ sender: Any) {
        //show alert
        let alert = UIAlertController(title: "Sign out", message: "Do you want to sign out?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (nil) in
            //sign out
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            //let SignInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInID") as! SignInVC
            //self.present(SignInVC, animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
