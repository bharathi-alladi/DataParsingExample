//
//  EditViewController.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 14/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var viewModel: EditViewModel!
    var textField_ref : UITextField?
    
    @IBOutlet var editTableView : UITableView!
    @IBOutlet var tableView_bottomConstraint : NSLayoutConstraint!
    
    
    
    class func initWithViewModel(_ viewModel: EditViewModel) -> EditViewController {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        vcObj.viewModel = viewModel
        vcObj.viewModel.viewController = vcObj
        return vcObj
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editTableView.dataSource = self
        self.editTableView.delegate = self
        
        // below code is used to remove unwanted cells in Tableview by keeping footer to the tableView .....
        
        let rect = CGRect.init(x: 0, y: 0, width: 0, height: 0)
        let view = UIView.init(frame: rect)
        editTableView.tableFooterView = view
        
        let center : NotificationCenter = NotificationCenter.default;
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name:   UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:    UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        
        DispatchQueue.main.async {
            
            let rect:CGRect? = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect
            let keyboardHeight = rect?.size.height ?? 100
            
            self.tableView_bottomConstraint.constant = keyboardHeight
            self.editTableView.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        DispatchQueue.main.async {
            self.tableView_bottomConstraint.constant = 0
            self.editTableView.layoutIfNeeded()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        textField_ref?.resignFirstResponder()
    }
}

extension EditViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EditTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell") as! EditTableViewCell
        
        let editDataModel = self.viewModel.getDataForCell(indexPath.row)
        cell.lable.text = editDataModel[0]
        cell.textField.text = editDataModel[1]
        cell.textField.tag = indexPath.row
        cell.parentView = self
        cell.configureTextfielddelegate()
        
        if indexPath.row == 2 {
            cell.textField.keyboardType = .numberPad
        }
        else {
            cell.textField.keyboardType = .default
        }
        
        return cell
    }
}

extension EditViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! EditTableViewCell
        cell.textField.becomeFirstResponder()
    }
}

extension EditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let rowNumber = textField.tag
        
        if(rowNumber < 3) {
            
            let nextCellRowNumber = rowNumber + 1
            let nextCell = self.editTableView.cellForRow(at: IndexPath.init(row: nextCellRowNumber, section: 0)) as? EditTableViewCell
            if nextCell != nil {
                let nextTextField = nextCell?.textField
                nextTextField?.becomeFirstResponder()
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.textField_ref = textField
        
        let rowNumber = self.textField_ref?.tag
        let indexPath = IndexPath.init(row: rowNumber!, section: 0)
        self.editTableView.scrollToRow(at: indexPath, at: .none, animated: false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.textField_ref = nil
    }
}

