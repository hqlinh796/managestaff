//
//  ViewController.swift
//  ManageStaff
//
//  Created by administrator on 11/27/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

var userAccount = user()
class ViewController: UIViewController {
    
    //MARK: OUTLETS
    
    @IBOutlet weak var checkIn: UIButton!
    @IBOutlet weak var checkInList: UIButton!
    @IBOutlet weak var manageStaff: UIButton!
    @IBOutlet weak var imageviewAvatarUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    let child = SpinnerViewController()
    var ref : DatabaseReference!
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardAction()
        ref = Database.database().reference()
      
        
        self.startLoading(child: child)
        //load user info
        loadUserToGlobalVar() {
            if userAccount.role == "Nhân viên" {
                self.setupForStaff()
            }
        }

        
    }
    
    func setupAvatar(){
        imageviewAvatarUser.layer.cornerRadius = imageviewAvatarUser.frame.width/2
        imageviewAvatarUser.clipsToBounds = true
        imageviewAvatarUser.layer.borderColor = UIColor.white.cgColor
        imageviewAvatarUser.layer.borderWidth = 4
    }
    
    
    func setupForStaff(){
        self.checkIn.isEnabled = false
        self.checkInList.isEnabled = false
        self.manageStaff.isEnabled = false
        self.checkIn.setTitleColor(UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.7), for: .normal)
        self.checkInList.setTitleColor(UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.7), for: .normal)
        self.manageStaff.setTitleColor(UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.7), for: .normal)
    }
    
    //-----FUNCTION-------
    func load(url: URL){
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data)  {
                    imageAvatar = image
                    self.imageviewAvatarUser.image = image
                }
            }
    }
    
    func loadUserToGlobalVar(completion: @escaping ()->()){
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            userAccount.email = value?["email"] as? String ?? ""
            userAccount.firstname = value?["firstname"] as? String ?? ""
            userAccount.phone = value?["phone"] as? String ?? ""
            userAccount.role = value?["role"] as? String ?? ""
            userAccount.sex = value?["sex"] as? String ?? ""
            userAccount.uid = self.user!.uid
            userAccount.lastname = value?["lastname"] as? String ?? ""
            userAccount.image = value?["imgurl"] as? String ?? ""
            userAccount.department = value?["department"] as? String ?? ""
            userAccount.leaderid = value?["leaderid"] as? String ?? ""
            userAccount.salary = value?["salary"] as? String ?? ""
            self.labelName.text = userAccount.firstname
            dispatchGroup.leave()
            
        }) { (error) in
            print("Can't load user info")
        }
        
        dispatchGroup.notify(queue: .main){
            self.stopLoading(child: self.child)
            self.load(url: URL(string: userAccount.image)!)
            completion()
        }
    }
    
    @IBAction func ShowCalendarVC(_ sender: Any) {
        if userAccount.role == "Nhân viên"{
            let ScheduleVC = self.storyboard?.instantiateViewController(withIdentifier: "StaffID") as! StaffVC
            ScheduleVC.modalPresentationStyle = .fullScreen
            self.present(ScheduleVC, animated: true, completion: nil)
        }
        else {
            let ScheduleVC = self.storyboard?.instantiateViewController(withIdentifier: "ManagerID") as! ManagerVC
            ScheduleVC.modalPresentationStyle = .fullScreen
            self.present(ScheduleVC, animated: true, completion: nil)
        }
        
        
    }
    
    
    
    //create and start loading view
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


extension UIViewController{
    func showNotif(title: String, mes: String){
        let alert = UIAlertController(title: title, message: mes, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
}



