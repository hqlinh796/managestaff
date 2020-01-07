//
//  SignInVC.swift
//  ManageStaff
//
//  Created by administrator on 11/28/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth

var isAlert = false
class SignInVC: UIViewController {

   
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //subview
        
        
        //tap Anywhere
        self.dismissKeyboard()

        //alert reset password
        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert), name: NSNotification.Name(rawValue: "AlertResetPassword"), object: nil)
        
    }
    

    @IBAction func tapOnSignIn(_ sender: Any) {
        dismissKeyboardAction()
        //validate input
        let err = validateInput()
        if !err.isEmpty{
            showError(error: err)
            return
        }
        
        Auth.auth().signIn(withEmail: textfieldEmail.text!, password: textfieldPassword.text!) { (result, error) in
            
            if error != nil{
                self.showError(error: "Email or password is incorrect. Try again!")
                return
            }else{
                //transition to home screen
                let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeID") as! ViewController
                HomeVC.modalPresentationStyle = .fullScreen
                self.present(HomeVC, animated: true, completion: nil)
            }
        }
        
        
    }
   
    
    func validateInput() -> String{
        if ((textfieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! || textfieldPassword.text!.isEmpty){
            return "Hãy điền đủ thông tin"
        }
        
        //check email has @
        if !textfieldEmail.text!.contains("@"){
            return "Email không hợp lệ"
        }
        
        //check password
        if !isValidPassword(password: textfieldPassword.text!){
            return "Mật khẩu phải chứa ít nhất: 1 số, 1 chữ thường 1 chữ in hoa và độ dài ít nhất 8 kí tự"
        }
        
        return ""
    }
    
    func showError(error: String){
        let alert = UIAlertController(title: "Lỗi", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            let HomeVC = storyboard?.instantiateViewController(withIdentifier: "HomeID") as! ViewController
            HomeVC.modalPresentationStyle = .fullScreen
            self.present(HomeVC, animated: true, completion: nil)
        }
    }
    
    //show alert reset password
    @objc func presentAlert(){
        let alert = UIAlertController(title: "Successful", message: "Please check your inbox mail and follow those steps to reset your password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    //check valid pass
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    
}


extension UIViewController{
    @objc func dismissKeyboard(){
        let tapOnScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAction))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapOnScreen)
    }
    @objc func dismissKeyboardAction(){
        view.endEditing(true)
    }
}

