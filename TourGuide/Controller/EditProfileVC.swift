//
//  EditProfileVC.swift
//  TourGuide
//
//  Created by samaa on 21/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: -Helper Functions
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = #colorLiteral(red: 0.1753656268, green: 0.2369565666, blue: 0.4083199501, alpha: 1)
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Edit Profile"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
