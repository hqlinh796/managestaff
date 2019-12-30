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
    @IBOutlet weak var labelError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //subview
        labelError.isHidden = true
        
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
                //self.navigateToMainNavigationView()
                self.present(HomeVC, animated: true, completion: nil)
            }
        }
        
        
    }
   
    
    func validateInput() -> String{
        if ((textfieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! || textfieldPassword.text!.isEmpty){
            return "Please fill all fields!"
        }
        
        //check email has @
        if !textfieldEmail.text!.contains("@"){
            return "Email is incorrect!"
        }
        
        //check password
        if !isValidPassword(password: textfieldPassword.text!){
            return """
            Password must contain: 1 number, 1 lower character,
            1 uppper character and must has at least 8 characters
            """
        }
        
        return ""
    }
    
    func showError(error: String){
        labelError.text = error
        labelError.isHidden = false
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            //navigateToMainNavigationView()
            let HomeVC = storyboard?.instantiateViewController(withIdentifier: "HomeID") as! ViewController
            //self.navigateToMainNavigationView()
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
    
    /*
    func navigateToMainNavigationView(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else{
            return
        }
        
        mainNavigationVC.modalPresentationStyle = .fullScreen
        
        present(mainNavigationVC, animated: true, completion: nil)
    }
 */
    
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

