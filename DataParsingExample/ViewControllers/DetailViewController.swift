//
//  DetailViewController.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 7/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController  {
    
    @IBOutlet var dataView : UIView!
    @IBOutlet var activityIndicator : UIActivityIndicatorView!
    @IBOutlet var idLbl : UILabel!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var profilePicLbl : UILabel!
    @IBOutlet var favouriteLbl :UILabel!
    @IBOutlet var urlLink : UILabel!
    
    @IBOutlet var emailLabl : UILabel!
    @IBOutlet var phoneNumber :UILabel!
    @IBOutlet var createLbl :UILabel!
    @IBOutlet var updateLbl :UILabel!
    
    @IBOutlet var fullname : UILabel!
    
    
    var viewModel: DetailViewModel!
    
    class func initWithViewModel(_ viewModel: DetailViewModel) -> DetailViewController {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vcObj.viewModel = viewModel
        vcObj.viewModel.viewController = vcObj
        return vcObj
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = self.viewModel.getFirstName()
        self.activityIndicator.startAnimating()
        self.viewModel.fetchDetails()
        self.fullname.text = self.viewModel.getFullName()
    }
    
    func populateIntialView(_ contact : CoreDataModel){
        self.idLbl.text = String(contact.id)
        self.firstNameLabel.text = contact.first_name
        self.lastNameLabel.text = contact.last_name
        self.profilePicLbl.text = String(contact.profile_pic)
        self.favouriteLbl.text = String(contact.favorite)
        self.urlLink.text = String(contact.url)
        
    }
    
    func populateOnSuccessView(_ detailData : DetailDataModel) {
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.activityIndicator.stopAnimating()
            self.emailLabl.text = detailData.email
            self.phoneNumber.text = detailData.phone_number
            self.createLbl.text = detailData.created_at
            self.updateLbl.text = detailData.updated_at
            
            let rightBarButton = UIBarButtonItem.init(title: "Edit", style: .plain, target: self, action: #selector(DetailViewController.rightBarButtonAction))
            self.navigationItem.rightBarButtonItem = rightBarButton
            
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
    
    @objc func rightBarButtonAction() {
        self.viewModel.routeToEditView()
    }
}



