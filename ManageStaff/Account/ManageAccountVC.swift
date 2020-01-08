//
//  ManageAccountVC.swift
//  ManageStaff
//
//  Created by administrator on 11/29/19.
//  Copyright © 2019 linh. All rights reserved.
//

//string to QR Code https://medium.com/@dominicfholmes/generating-qr-codes-in-swift-4-b5dacc75727c


import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ManageAccountVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    

    
    let pickerviewSex = UIPickerView()
    @IBOutlet weak var textfieldFirstName: UITextField!
    @IBOutlet weak var textfieldPhone: UITextField!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelDepartment: UILabel!
    @IBOutlet weak var textfieldSex: UITextField!
    @IBOutlet weak var imageviewQRCode: UIImageView!
    @IBOutlet weak var imageviewAvatar: UIImageView!
    @IBOutlet weak var labelFullName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var buttonSignOut: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    let arraySex = ["Nam", "Nữ"]
    var firstName = ""
    var lastName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserInfo()
        setupForImageView()
        setupForPicker()
        setup()
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
        let alert = UIAlertController(title: "ĐĂNG XUẤT", message: "Bạn muốn đăng xuất?", preferredStyle: .alert)
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
        
        //validate input
        if textfieldFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines).firstIndex(of: " ") == nil {
            //show alert error
            showAlert(title: "Lỗi", mes: "Vui lòng nhập tên đầy đủ")
            return
        }
        
        if let numbersRange = textfieldFirstName.text!.rangeOfCharacter(from: .decimalDigits) {
            showAlert(title: "Lỗi", mes: "Tên không đúng định dạng")
            return
        }
        
        
        
        //
        var fullName = textfieldFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
        firstName = fullName![fullName!.count - 1]
        lastName = ""
        for word in 0..<fullName!.count - 1{
            lastName = lastName + " " + fullName![word]
        }
        lastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        //store image to cloud
        let child = SpinnerViewController()
        self.startLoading(child: child)
        storeImageandUpdateInfo(uid: userAccount.uid, completion: {urlImage in
            let ref : DatabaseReference!
            ref = Database.database().reference()
            ref.child("users").child(userAccount.uid).updateChildValues([
                "firstname": self.firstName,
                "lastname": self.lastName,
                "sex": self.textfieldSex.text!,
                "phone": self.textfieldPhone.text!,
                "imgurl": urlImage
                ], withCompletionBlock: { (error, DatabaseReference) in
                    if error != nil {
                        self.showAlert(title: "Lỗi", mes: "Không thể lưu chỉnh sửa, hãy thử lại")
                        return
                    }
            })
            self.stopLoading(child: child)
            self.updateUserAccountGlobal()
            //notify success
            self.showAlert(title: "Thành công", mes: "Cập nhật tài khoản thành công")
        })
    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
    
    @IBAction func onChangingFirstName(_ sender: Any) {
        //let lastName = textfieldLastName?.text ?? ""
        labelFullName.text = textfieldFirstName.text!
    }
    
    
    @IBAction func tapOnCamera(_ sender: Any) {
        chooseImage()
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
        lastName = userAccount.lastname
        firstName = userAccount.firstname
        self.textfieldFirstName.text = lastName + " " + firstName
        self.textfieldPhone.text = userAccount.phone
        self.labelRole.text = userAccount.role
        self.labelDepartment.text = userAccount.department
        self.textfieldSex.text = userAccount.sex
        self.labelFullName.text = self.textfieldFirstName.text!
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
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        self.imageviewQRCode.image = UIImage(ciImage: scaledQrImage)
        
        //load image avatr
        //imageviewAvatar.load(url: URL(string: userAccount.image)!)
        imageviewAvatar.image = imageAvatar
    }
    
    func setupForImageView(){
        let tapOnImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageviewAvatar.isUserInteractionEnabled = true;
        imageviewAvatar.addGestureRecognizer(tapOnImage)
        imageviewAvatar.layer.cornerRadius = imageviewAvatar.frame.width/2
        imageviewAvatar.layer.borderColor = UIColor.white.cgColor
        imageviewAvatar.layer.borderWidth = 2
    }
    
    @objc func chooseImage(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func setup(){
        self.dismissKeyboard()
        buttonSignOut.layer.cornerRadius = 0
        
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
    
    
    func showAlert(title: String, mes: String){
        let alert = UIAlertController(title: title, message: mes, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
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
    
    func updateUserAccountGlobal(){
        userAccount.firstname = firstName
        userAccount.lastname = lastName
        userAccount.sex = textfieldSex.text!
        userAccount.phone = textfieldPhone.text!
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


//add border one edge https://stackoverflow.com/questions/17355280/how-to-add-a-border-just-on-the-top-side-of-a-uiview
extension UIView {
    
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: 0, y: frame.height, width: frame.size.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
}
