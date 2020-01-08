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
    
    let child = SpinnerViewController()
    var ref : DatabaseReference!
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        self.startLoading(child: child)
        //load user info
        loadUserToGlobalVar() {
            if userAccount.role == "Nhân viên" {
                self.setupForStaff()
            }
        }

        
    }
    
    func setupForStaff(){
        self.checkIn.isEnabled = false
        self.checkInList.isEnabled = false
        self.checkIn.backgroundColor = .gray
        self.checkInList.backgroundColor = .gray
    }
    
    //-----FUNCTION-------
    func load(url: URL){
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data)  {
                    imageAvatar = image
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




