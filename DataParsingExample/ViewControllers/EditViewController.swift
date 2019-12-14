//
//  EditViewController.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 14/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class EditViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
   
    var viewModel: EditViewModel!
    
    @IBOutlet var editTableView : UITableView!
   
    
    
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
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EditTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell") as! EditTableViewCell
        
        let editDataModel = self.viewModel.getDataForCell(indexPath.row)
        cell.Lable.text = editDataModel[0]
        cell.textField.text = editDataModel[1]
    
        return cell
    }
    
    
    
}
