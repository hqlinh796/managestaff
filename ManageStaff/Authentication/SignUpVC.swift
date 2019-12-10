//
//  SignUpVC.swift
//  ManageStaff
//
//  Created by administrator on 11/28/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import Firebase

var imageAvatar:UIImage?
class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var isUploadAvarar = false
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldConfirmPassword: UITextField!
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var textfieldPhone: UITextField!
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var imageviewAvatar: UIImageView!
    
    var urlImage = "https://firebasestorage.googleapis.com/v0/b/managestaff-cc156.appspot.com/o/Zjw7LLp3ctNOArBplgmxN8kmjoW2.png?alt=media&token=02a55f39-691b-488a-b15a-a712d36ea484"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelError.isHidden = true
        
        //tap on image
        let tapOnImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageviewAvatar.isUserInteractionEnabled = true;
        imageviewAvatar.addGestureRecognizer(tapOnImage)
        
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
        isUploadAvarar = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOnSignUp(_ sender: Any) {
        
        //Validate input
        let err = validateInput()
        if !err.isEmpty {
            showError(error: err)
            return
        }
        
        //Create User
        Auth.auth().createUser(withEmail: textfieldEmail.text!, password: textfieldPassword.text!) { (Result, Error) in
            
            //check if error != nil => show error
            if Error != nil {
                self.showError(error: "Failt to create account, try again!")
                return
            }
            //upload image to cloud
            
            //store user to database
            let db = Firestore.firestore()
            
            db.collection("users").document(Result!.user.uid).setData([
                "name": self.textfieldName.text!,
                "phone": self.textfieldPhone.text!,
                "image": self.urlImage,
                "role": "",
                "uid": Result!.user.uid
            ]) { err in
                if err != nil {
                    self.showError(error: "Failt to create account, check your input and try again!")
                    return
                }else{
                    //Transition to home screen
                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeID") as! ViewController
                    self.present(homeVC, animated: true, completion: nil)
                }
            }
            
        }
        
        
    }
    
    @IBAction func tapOnSignIn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func showError(error: String){
        labelError.text = error
        labelError.isHidden = false
    }
    
    func validateInput() -> String{
        //check empty
        if (textfieldName.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textfieldEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textfieldPassword.text!.isEmpty || textfieldConfirmPassword.text!.isEmpty || textfieldPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            return "Please fill all fields!"
        }
        //check email has @
        if !textfieldEmail.text!.contains("@"){
            return "Email is incorrect!"
        }
        //check password and password confirm
        if textfieldPassword.text! != textfieldConfirmPassword.text!{
            return "Password confirm is incorrect!"
        }
        if !isValidPassword(password: textfieldPassword.text!){
            return """
            Password must contain: 1 number, 1 lower character,
                    1 uppper character and must has at least 8 characters
            """
        }
        //check name has at least 2 words
        if !textfieldName.text!.trimmingCharacters(in: .whitespacesAndNewlines).contains(" "){
            return "Fill full name"
        }
        //check if phone is not number
        if Int(textfieldPhone.text!) == nil {
            return "Phone must number"
        }
        
        
        return ""
    }
    
    //check password invalid:
    //pass has at least 1 number, 1 lower character, 1 upper character, has at least 8 characters
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    //upload image to cloud
    func storeImageToCloud(uid: String, child: SpinnerViewController){
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
                self.urlImage = downloadURL.absoluteString
                self.stopLoading(child: child)
            }
        }
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



