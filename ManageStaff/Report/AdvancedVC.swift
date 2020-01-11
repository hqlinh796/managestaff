//
//  AdvancedVC.swift
//  ManageStaff
//
//  Created by administrator on 12/25/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit

protocol FilterAndSortDelegate {
    func filterBy(filterBy: filter, sortBy: Int, isDesc: Bool)
}


class AdvancedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    

    //-----OUTLET-----
    @IBOutlet weak var tableSort: UITableView!
    @IBOutlet weak var tableFilter: UITableView!
    @IBOutlet weak var textfieldTime: UITextField!
    let datePicker = UIPickerView()
    @IBOutlet weak var buttonOrder: UIButton!
    
    var delegate: FilterAndSortDelegate?
    var isDesc = false
    var filterBy = filter()
    
    let arraySort = ["Tên", "Phòng ban", "Chức vụ"]
    var indexPathSort = IndexPath()
    
    let arrayFilter = [["Nam", "Nữ"], ["Nhân viên", "Trưởng phòng", "Phó phòng", "Giám đốc"], ["Giám đốc", "Nhân sự", "Kỹ thuật", "Kế toán", "Hậu cần"]]
    
    /*
    var arraySexFilter = ["Nam", "Nữ"]
    let arrayRoleFilter = ["Giám đốc", "Nhân sự", "Kỹ thuật", "Kế toán", "Hậu cần"]
    let arrayRoomFilter = ["Nhân viên", "Trưởng phòng", "Phó phòng", "Giám đốc"]*/
    var arrayHeaderFilter = ["Giới tính", "Chức vụ", "Phòng ban"]
    
    var selectSection: [Int] = []
    var arrayIndexPathFilter: [IndexPath] = []
    
    let arrayTime = [["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"], ["2019", "2020", "2021"]]
    
    var rowSort = 0
    var lastHeight: CGFloat = 210.0
    var heightOfTableFilter: NSLayoutConstraint = NSLayoutConstraint()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFilterAndSort()
        setupDatePicker()
        heightOfTableFilter = NSLayoutConstraint(item: tableFilter, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: lastHeight)
        tableFilter.addConstraint(heightOfTableFilter)
    }
    
    
    
    //ACTION
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tapOnApply(_ sender: Any) {
        //add filter to object filter
        getFilterBy()
        delegate?.filterBy(filterBy: filterBy, sortBy: indexPathSort.row, isDesc: isDesc)
        //filterBy = filter()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOnOrder(_ sender: Any) {
        if buttonOrder.isSelected {
            buttonOrder.isSelected = false
            isDesc = false
        }else{
            buttonOrder.isSelected = true
            isDesc = true
        }
    }
   
    
    //Setup for table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableSort{
            return arraySort.count
        }
        return arrayFilter[section].count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableSort{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell") as! SortTVC
            cell.labelTitle.text = arraySort[indexPath.row]
            let imageView = UIImageView(frame: CGRect(x: tableView.frame.size.width - 50, y: 15, width: 20, height: 20))
            if indexPathSort == indexPath {
                
                imageView.image = UIImage(named: "tick")
                
            }else{
                imageView.image = UIImage(named: "noneImage")
            }
            cell.addSubview(imageView)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterTVC
            cell.labelTitle.text = arrayFilter[indexPath.section][indexPath.row]
            let imageView = UIImageView(frame: CGRect(x: tableView.frame.size.width - 50, y: 15, width: 20, height: 20))
            for i in arrayIndexPathFilter {
                if i == indexPath{
                    imageView.image = UIImage(named: "tick")
                    cell.addSubview(imageView)
                    return cell
                }
            }
            
            imageView.image = UIImage(named: "noneImage")
            cell.addSubview(imageView)
            return cell
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableSort{
            return 1
        }
        return arrayFilter.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableSort{
            return 50
        }
        
        for section in selectSection{
            if section == indexPath.section{
                return 50
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tableSort {
            return 50
        }
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        //filter
        if tableView == tableFilter{
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 70))
            
            let title = UILabel(frame: CGRect(x: 30, y: 25, width: tableView.frame.size.width, height: 20))
            title.textColor = UIColor(red: 36/255, green: 74/255, blue: 145/255, alpha: 1)
            title.font = UIFont.systemFont(ofSize: 20)
            title.text = arrayHeaderFilter[section]
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showRow(sender:)))
            tapRecognizer.name = String(section)
            tapRecognizer.numberOfTapsRequired = 1
            tapRecognizer.numberOfTouchesRequired = 1
            
            let imageView = UIImageView(frame: CGRect(x: tableView.frame.size.width - 50, y: 25, width: 20, height: 20))
            if selectSection.contains(section){
                imageView.image = UIImage(named: "down section")
            }else{
                imageView.image = UIImage(named: "right section")
            }
            view.addGestureRecognizer(tapRecognizer)
            view.addSubview(title)
            view.bringSubviewToFront(title)
            view.addSubview(imageView)
            view.bringSubviewToFront(imageView)
            let color = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = 2
            return view
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 25))
        view.backgroundColor = .init(UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1))
        let title = UILabel(frame: CGRect(x: 30, y: 5, width: tableView.frame.size.width, height: 20))
        title.text = "Sắp xếp"
        title.textColor = UIColor(red: 27/255, green: 57/255, blue: 117/255, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 22)
        view.addSubview(title)
        
        return view
        
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableFilter{
            for i in arrayIndexPathFilter{
                if i == indexPath {
                    let index = arrayIndexPathFilter.firstIndex(of: i)
                    arrayIndexPathFilter.remove(at: index!)
                    print(arrayIndexPathFilter.count)
                    tableView.reloadRows(at: [indexPath], with: .none)
                    return
                }
            }
            arrayIndexPathFilter.append(indexPath)
            tableView.reloadRows(at: [indexPath], with: .none)
        }else{
            if indexPathSort != indexPath{
                indexPathSort = indexPath
            }
            tableView.reloadData()
            return
        }
    }
    
    
    //SETUP FOR DATE PICKER
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return arrayTime.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayTime[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayTime[component][row]
    }
    
    
    //-------FUNCTION HELPER
    
    
    
    func getFilterBy(){
        resetFilterBy()
        for index in arrayIndexPathFilter {
            if index.section == 0 {
                filterBy.sex.append(arrayFilter[0][index.row])
            }else if index.section == 1{
                filterBy.role.append(arrayFilter[1][index.row])
            }else{
                filterBy.department.append(arrayFilter[2][index.row])
            }
        }
    }
    
    @objc func showRow(sender: UITapGestureRecognizer){
        let section = Int(sender.name!)!
        if let index = selectSection.firstIndex(of: section){
            selectSection.remove(at: index)
            heightOfTableFilter.constant = lastHeight - CGFloat(50 * arrayFilter[section].count)
            lastHeight = lastHeight - CGFloat(50 * arrayFilter[section].count)
        }else{
            selectSection.append(section)
            heightOfTableFilter.constant = lastHeight + CGFloat(50 * arrayFilter[section].count)
            lastHeight = lastHeight + CGFloat(50 * arrayFilter[section].count)
        }
        tableFilter.reloadSections([section], with: .none)
    }
    
    func setupDatePicker(){
        datePicker.dataSource = self
        datePicker.delegate = self
       
        textfieldTime.setLeftPaddingPoints(30)
        textfieldTime.setRightPaddingPoints(30)
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        textfieldTime.inputAccessoryView = toolbar
        // add datepicker to textField
        textfieldTime.inputView = datePicker
        
    }
    
    @objc func doneDatePicker(){
        filterBy.month = String(datePicker.selectedRow(inComponent: 0) + 1)
        filterBy.year = String(datePicker.selectedRow(inComponent: 1) + 2019)
        if filterBy.month.count == 1 {
            filterBy.month = "0" + filterBy.month
        }
        textfieldTime.text = filterBy.month + "/" + filterBy.year
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func showError(error: String){
        
    }
    
    func loadFilterAndSort(){
        //sort
        indexPathSort = IndexPath.init(row: rowSort, section: 0)
        
        //filter
        for i in 0..<arrayFilter[0].count{
            for j  in 0..<filterBy.sex.count{
                if filterBy.sex[j] == arrayFilter[0][i]{
                    let indexPathTemp = IndexPath.init(row: i, section: 0)
                    arrayIndexPathFilter.append(indexPathTemp)
                }
            }
        }
        
        for i in 0..<arrayFilter[1].count{
            for j  in 0..<filterBy.role.count{
                if filterBy.role[j] == arrayFilter[1][i]{
                    let indexPathTemp = IndexPath.init(row: i, section: 1)
                    arrayIndexPathFilter.append(indexPathTemp)
                }
            }
        }
        
        for i in 0..<arrayFilter[2].count{
            for j  in 0..<filterBy.department.count{
                if filterBy.department[j] == arrayFilter[2][i]{
                    let indexPathTemp = IndexPath.init(row: i, section: 2)
                    arrayIndexPathFilter.append(indexPathTemp)
                }
            }
        }
        textfieldTime.text = filterBy.month + "/" + filterBy.year
        buttonOrder.isSelected = isDesc
        tableSort.delegate = self
        tableSort.dataSource = self
    }
    
    func resetFilterBy(){
        filterBy.sex.removeAll()
        filterBy.department.removeAll()
        filterBy.role.removeAll()
    }
    
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
