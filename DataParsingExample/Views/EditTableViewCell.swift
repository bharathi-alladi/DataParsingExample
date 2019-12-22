//
//  EditTableViewCell.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 14/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {

    @IBOutlet var lable : UILabel!
    @IBOutlet var textField : UITextField!
    
    var parentView : EditViewController!
    
    func configureTextfielddelegate() {
        
        self.textField.delegate = parentView
    }
}
