//
//  ViewController.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 22/11/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var data_tableView : UITableView!
    
    var completionHandler : ((Data?,URLResponse?,Error?) -> Void )?
    var fetchedData : [CoreDataModel] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.data_tableView.dataSource = self
        self.data_tableView.delegate = self
       
        self.completionHandler = {
            (data : Data?, urlresponse : URLResponse?, error : Error? ) -> Void in
            
            if data != nil {
                let decoder = JSONDecoder.init()
                do {
                    self.fetchedData =  try decoder.decode([CoreDataModel].self, from: data!)
                } catch {
                    print(error.localizedDescription)
                    
                }
                DispatchQueue.main.async(execute: {() -> Void in
                    self.activityIndicator.stopAnimating()
                    self.data_tableView.reloadData()
                })
            }
            else {
                // show an alert here
                let alertController = UIAlertController.init(title: "Error", message: error?.localizedDescription ?? "Unknown Error", preferredStyle: .alert)
                let alertAction = UIAlertAction.init(title: "ok", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            
        }
        self.activityIndicator.startAnimating()
        
        let serviceManager = ServiceManager.init()
        serviceManager.getContactList(onSuccess: self.completionHandler!)
    }
    
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        
        let CoreDataModel = fetchedData[indexPath.row]
        cell.firstNameLbl.text = CoreDataModel.first_name
        cell.lastNameLbl.text = CoreDataModel.last_name
        
        return cell
    }
}







