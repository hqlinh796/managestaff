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
import Firebase

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
        
        //tap anywhere
        self.dismissKeyboard()
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
        let child = SpinnerViewController()
        self.startLoading(child: child)
        storeImageandUpdateInfo(uid: userAccount.uid, completion: {urlImage in
            print(urlImage)
            let ref : DatabaseReference!
            ref = Database.database().reference()
            ref.child("users").child(userAccount.uid).updateChildValues([
                "name": self.textfieldName.text!,
                "phone": self.textfieldPhone.text!,
                "imgURL": urlImage
                ])
            self.stopLoading(child: child)
            self.delegate?.updateImageAvatar(image: self.imageviewAvatar.image!, phone: self.textfieldPhone.text!, name: self.textfieldName.text!)
            self.dismiss(animated: true, completion: nil)
            
            //update image in manage account view
        })
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
    
    func storeImageandUpdateInfo(uid: String, completion: @escaping (String)->()){
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
                completion(userAccount.image)
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


