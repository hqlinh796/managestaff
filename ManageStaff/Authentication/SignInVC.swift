//
//  SignInVC.swift
//  ManageStaff
//
//  Created by administrator on 11/28/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {

    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var labelError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelError.isHidden = true
    }
    
    
    
    
    @IBAction func tapOnSignIn(_ sender: Any) {
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
        return ""
    }
    
    func showError(error: String){
        labelError.text = error
        labelError.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
           //self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
            let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeID") as! ViewController
            self.present(HomeVC, animated: true, completion: nil)
        }
    }
}
