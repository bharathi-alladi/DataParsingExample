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
    
    var data : CoreDataModel!
    var detailData : DetailDataModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.idLbl.text = String(self.data.id)
        self.firstNameLabel.text = self.data.first_name
        self.lastNameLabel.text = self.data.last_name
        self.profilePicLbl.text = String(self.data.profile_pic)
        self.favouriteLbl.text = String(self.data.favorite)
        self.urlLink.text = String(self.data.url)
        
        
        
        self.activityIndicator.startAnimating()
        
        ServiceManager.init().getDetails(self.data.url, onSuccess: {
            (data, urlresponse, error) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.activityIndicator.stopAnimating()
            })
            if data != nil {
                let decoder = JSONDecoder.init()
                do {
                    self.detailData =  try decoder.decode(DetailDataModel.self, from: data!)
                    
                    // your data is parsed and ready here...!!
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.emailLabl.text = self.detailData.email
                        self.phoneNumber.text = self.detailData.phone_number
                        self.createLbl.text = self.detailData.created_at
                        self.updateLbl.text = self.detailData.updated_at
                    })
                } catch {
                    print(error.localizedDescription)
                }
            }
            else {
                // when there is a network error in fetching data
                // you will come here..!!
                
            }
        })
        
    }
    

}
