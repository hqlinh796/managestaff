//
//  SignUpVC.swift
//  ManageStaff
//
//  Created by administrator on 11/28/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

var imageAvatar:UIImage?
class SignUpVC: UIViewController {

   
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldConfirmPassword: UITextField!
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var textfieldPhone: UITextField!
    @IBOutlet weak var imageviewAvatar: UIImageView!
    
    var urlImage = "https://firebasestorage.googleapis.com/v0/b/managestaff-cc156.appspot.com/o/Zjw7LLp3ctNOArBplgmxN8kmjoW2.png?alt=media&token=02a55f39-691b-488a-b15a-a712d36ea484"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelError.isHidden = true
        
        //tap on image
        
        //tap anywhere
        self.dismissKeyboard()
    }
    
    
    @IBAction func tapOnSignUp(_ sender: Any) {
        dismissKeyboardAction()
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
            
            //store user to database realtime
            
            print("ID: ----------" + Result!.user.uid)
            let ref : DatabaseReference!
            ref = Database.database().reference().child("users")
            ref.child(Result!.user.uid).setValue([
                "email": self.textfieldEmail.text!,
                "name": self.textfieldName.text!,
                "phone": self.textfieldPhone.text!,
                "role": "1",
                "imgURL": self.urlImage
                ])
    
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeID") as! ViewController
            self.present(homeVC, animated: true, completion: nil)
            /*
            let db = Firestore.firestore()
            
            db.collection("users").document(Result!.user.uid).setData([
                "name": self.textfieldName.text!,
                "phone": self.textfieldPhone.text!,
                "image": self.urlImage,
                "role": "0",
                "uid": Result!.user.uid
            ]) { err in
                if err != nil {
                    self.showError(error: "Failed to create account, check your input and try again!")
                    return
                }else{
                    //Transition to home screen
                    self.navigateToMainNavigationView()
                }
            }
 */
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
    
    
    func navigateToMainNavigationView(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else{
            return
        }
        
        mainNavigationVC.modalPresentationStyle = .fullScreen
        
        present(mainNavigationVC, animated: true, completion: nil)
    }
    
}



