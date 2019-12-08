//
//  ViewController.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 22/11/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var data_tableView : UITableView!
    
    var viewModel: ListViewModel!
    
    // MARK: - init and viewDidLoad functions
    class func initWithViewModel(_ viewModel: ListViewModel) -> ListViewController {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        vcObj.viewModel = viewModel
        vcObj.viewModel.viewController = vcObj
        return vcObj
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Contacts"
        self.data_tableView.dataSource = self
        self.data_tableView.delegate = self
        
        self.activityIndicator.startAnimating()
        self.viewModel.fetchData()
    }
    
    // MARK: - custom functions
    func reloadTableView() {
        DispatchQueue.main.async(execute: {() -> Void in
            self.activityIndicator.stopAnimating()
            self.data_tableView.reloadData()
        })
    }
    
    func displayAlert(with error:Error?)  {
        // show an alert here
        DispatchQueue.main.async(execute: {() -> Void in
            let alertController = UIAlertController.init(title: "Error", message: error?.localizedDescription ?? "Unknown Error", preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
 
    // MARK: - tableview datasource functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        
        let coreDataModel = self.viewModel.getContact(index: indexPath.row)
        cell.firstNameLbl.text = coreDataModel.first_name
        cell.lastNameLbl.text = coreDataModel.last_name
        
        return cell
    }
    
    
    // MARK: - tableview delegate functions
    // (This function selects the cell and also deselectes it)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.rowSelected(indexPath.row)
    }
    
}







