//
//  ResetPasswordVC.swift
//  ManageStaff
//
//  Created by administrator on 12/7/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var textfieldEmail: UITextField!
     @IBOutlet weak var labelError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelError.isHidden = true
        // Do any additional setup after loading the view.
        
        //tap anywhere
        self.dismissKeyboard()
    }
    
   
    //-----ACTION--------
    @IBAction func tapOnSendEmail(_ sender: Any) {
        dismissKeyboardAction()
        //validate email
        guard let err = validateEmail(email: textfieldEmail.text!) else {
            //send email to reset
            Auth.auth().sendPasswordReset(withEmail: textfieldEmail.text!) { Error in
                if Error == nil {
                    print("Send email successfully")
                    //dismiss reset password screen
                    self.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: .init("AlertResetPassword"), object: nil)
                    })
                    //show alert
                }
            }
            return
        }
        showError(err: err)
    }
    
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //--------FUNCTION---------
    func validateEmail(email: String) -> String?{
        if email.isEmpty{
            return "Write your email to reset password"
        }
        //check by regexp
        
        let emailRegex = "^[a-z][a-z0-9_\\.]{5,32}@[a-z0-9]{2,}(\\.[a-z0-9]{2,4}){1,2}$"
        if (!NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: textfieldEmail.text!)){
            return "Email is incorrect"
        }
        return nil
    }

    func showError(err: String){
        labelError.text = err
        labelError.isHidden = false
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Successful", message: "Check your inbox email and follow the link to reset your password", preferredStyle: .alert)
        present(alert, animated: false, completion: nil)
    }
    
    
}
