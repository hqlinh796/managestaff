//
//  EditAccountVC.swift
//  ManageStaff
//
//  Created by administrator on 12/3/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

protocol updateImageDelegate{
    func updateImageAvatar(image: UIImage, phone: String, name: String)
}
class EditAccountVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: updateImageDelegate?
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var imageviewAvatar: UIImageView!
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldPhone: UITextField!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapOnImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageviewAvatar.isUserInteractionEnabled = true;
        imageviewAvatar.addGestureRecognizer(tapOnImage)
        
        //show info
        showUserInfo()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func chooseImage(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage]
        imageviewAvatar.image = image as! UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func tapOnSave(_ sender: Any) {
        //validate input
        let err = validateInputEdit()
        if !err.isEmpty{
            showError(err: err)
            return
        }
        //store image to cloud
        storeImageToCloud(uid: userAccount.uid)
        let db = Firestore.firestore()
        db.collection("users").document(userAccount.uid).updateData([
            "name": textfieldName.text!,
            "phone": textfieldPhone.text!
        ])
        
        //update image in manage account view
        delegate?.updateImageAvatar(image: imageviewAvatar.image!, phone: textfieldPhone.text!, name: textfieldName.text!)
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showUserInfo(){
        self.textfieldEmail.text = userAccount.email
        self.textfieldPhone.text = userAccount.phone
        self.textfieldName.text = userAccount.name
        //load image avatr
        imageviewAvatar.image = imageAvatar
    }
    func storeImageToCloud(uid: String){
        let storageRef = Storage.storage().reference().child(uid + ".png")
        let data = imageviewAvatar.image?.pngData()
        imageAvatar = imageviewAvatar.image
        storageRef.putData(data!, metadata: nil) { (metadata, error) in
            // You can also access to download URL after upload.
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                userAccount.image = downloadURL.absoluteString
                let db = Firestore.firestore()
                db.collection("users").document(uid).updateData([
                    "image": userAccount.image
                    ])
            }
        }
    }
    
    //validate input
    func validateInputEdit() -> String{
        return ""
    }
    func showError(err: String){
        //show err
    }
    
    
}


