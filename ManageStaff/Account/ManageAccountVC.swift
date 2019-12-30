//
//  ManageAccountVC.swift
//  ManageStaff
//
//  Created by administrator on 11/29/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ManageAccountVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    

    
    let pickerviewSex = UIPickerView()
    @IBOutlet weak var textfieldFirstName: UITextField!
    @IBOutlet weak var textfieldLastName: UITextField!
    @IBOutlet weak var textfieldPhone: UITextField!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelDepartment: UILabel!
    @IBOutlet weak var textfieldSex: UITextField!
    @IBOutlet weak var imageviewQRCode: UIImageView!
    @IBOutlet weak var imageviewAvatar: UIImageView!
    @IBOutlet weak var labelFullName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelError: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    let arraySex = ["Nam", "Nữ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserInfo()
        setupForImageView()
        setupForPicker()
        labelError.isHidden = true
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arraySex[row]
    }
    
    
    
    //---- ACTION ----------
    @IBAction func tapOnSignOut(_ sender: Any) {
        //show alert
        let alert = UIAlertController(title: "Sign out", message: "Do you want to sign out?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (nil) in
            //sign out
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapOnSave(_ sender: Any) {
        labelError.isHidden = true
        //validate input
        
        //
        //store image to cloud
        let child = SpinnerViewController()
        self.startLoading(child: child)
        storeImageandUpdateInfo(uid: userAccount.uid, completion: {urlImage in
            let ref : DatabaseReference!
            ref = Database.database().reference()
            ref.child("users").child(userAccount.uid).updateChildValues([
                "firstname": self.textfieldFirstName.text!,
                "lastname": self.textfieldLastName.text!,
                "sex": self.textfieldSex.text!,
                "phone": self.textfieldPhone.text!,
                "imgurl": urlImage
                ], withCompletionBlock: { (error, DatabaseReference) in
                    if error != nil {
                        self.showError(err: "Không thể lưu chỉnh sửa, hãy thử lại")
                        return
                    }
            })
            self.stopLoading(child: child)
            //notify success
            
        })
    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
    
    @IBAction func onChangingFirstName(_ sender: Any) {
        let lastName = textfieldLastName?.text ?? ""
        let firstName = textfieldFirstName?.text ?? ""
        labelFullName.text = lastName + " " + firstName
    }
    
    
    @IBAction func onChangingLastName(_ sender: Any) {
        let lastName = textfieldLastName?.text ?? ""
        let firstName = textfieldFirstName?.text ?? ""
        labelFullName.text = lastName + " " + firstName
    }
    
    
    
    
    //------ FUNTION -------
    
    func setupForPicker(){
        pickerviewSex.dataSource = self
        pickerviewSex.delegate = self
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        textfieldSex.inputAccessoryView = toolbar
        // add pickerviewSex to textField
        textfieldSex.inputView = pickerviewSex
        
    }
    
    @objc func donePicker(){
        textfieldSex.text = arraySex[pickerviewSex.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
    
    
    func showUserInfo(){
       // self.labelEmail.text = userAccount.email
        self.textfieldLastName.text = userAccount.lastname
        self.textfieldFirstName.text = userAccount.firstname
        self.textfieldPhone.text = userAccount.phone
        self.labelRole.text = userAccount.role
        self.labelDepartment.text = userAccount.department
        self.textfieldSex.text = userAccount.sex
        self.labelFullName.text = userAccount.lastname + " " + userAccount.firstname
        let index = userAccount.email.indexDistance(of: "@")
        let startIndex = String.Index(encodedOffset: index!-4)
        let endIndex = String.Index(encodedOffset: index!+3)
        self.labelEmail.text = userAccount.email.replacingCharacters(in: startIndex...endIndex, with: "********")
        
        
        //string to QRImage
        let myString = userAccount.uid
        let data2 = myString.data(using: String.Encoding.ascii)
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        qrFilter.setValue(data2, forKey: "inputMessage")
        guard let qrImage = qrFilter.outputImage else { return }
        self.imageviewQRCode.image = UIImage(ciImage: qrImage)
        
        //load image avatr
        //imageviewAvatar.load(url: URL(string: userAccount.image)!)
        imageviewAvatar.image = imageAvatar
    }
    
    func setupForImageView(){
        let tapOnImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageviewAvatar.isUserInteractionEnabled = true;
        imageviewAvatar.addGestureRecognizer(tapOnImage)
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
    
    
    func showError(err: String){
        //show err
        labelError.text = err
        labelError.isHidden = false
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

extension UIImageView{
    func load(url: URL){
        DispatchQueue.global().async { [weak self] in
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data)  {
                DispatchQueue.main.async {
                    //imageAvatar = image
                    self?.image = image
                }
            }
        }
    }
}
}

extension StringProtocol {
    func indexDistance<S: StringProtocol>(of string: S) -> Int? {
        guard let index = range(of: string)?.lowerBound else { return nil }
        return distance(from: startIndex, to: index)
    }
}
