//
//  ManageAccountVC.swift
//  ManageStaff
//
//  Created by administrator on 11/29/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth


class ManageAccountVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, updateImageDelegate {
    func updateImageAvatar(image: UIImage, phone: String, name: String) {
        imageviewAvatar.image = image
        imageAvatar = image
        labelName.text = name
        labelPhone.text = phone
    }
    

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var imageviewQRCode: UIImageView!
    @IBOutlet weak var imageviewAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserInfo()
        
    }
    
    
    //---- ACTION ----------
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
            
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //------ FUNTION -------
    func showUserInfo(){
        self.labelEmail.text = userAccount.email
        self.labelPhone.text = userAccount.phone
        self.labelName.text = userAccount.name
        //string to QRImage
        let myString = userAccount.uid
        let data2 = myString.data(using: String.Encoding.ascii)
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        qrFilter.setValue(data2, forKey: "inputMessage")
        guard let qrImage = qrFilter.outputImage else { return }
        self.imageviewQRCode.image = UIImage(ciImage: qrImage)
        
        //load image avatr
        //imageviewAvatar.load(url: URL(string: userAccount.image)!)
        imageviewAvatar.image = imageAvatar
    }
}

extension UIImageView{
    func load(url: URL){
        DispatchQueue.global().async { [weak self] in
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data)  {
                DispatchQueue.main.async {
                    //imageAvatar = image
                    self?.image = image
                }
            }
        }
    }
}
}
