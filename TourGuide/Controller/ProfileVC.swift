//
//  ProfileVC.swift
//  TourGuide
//
//  Created by samaa on 21/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

protocol EditProfile {
    
    func editName(name: String)
    func editEmail(email: String)
    func editPhone(phone: String)
    
}


class ProfileVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    //MARK: -Variables
    
    
    //MARK: -View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

    //MARK: -IBActions

    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        
        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LogInVC") as! LogInVC
        
        logInVC.modalPresentationStyle = .fullScreen
        present(logInVC, animated: true, completion: nil)
    }
    
    @IBAction func editProfileBtnPressed(_ sender: UIButton) {
        
        let editProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "EditProfileVC") as! EditProfileVC
        
        editProfileVC.delegate = self
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    
    //MARK: -Helper Functions

    func setUpNavBar(){

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = " "
        backButton.image = #imageLiteral(resourceName: "backBtnIcon")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}


extension ProfileVC: EditProfile {
    
    func editName(name: String) {
        
        if !name.isEmpty {
            self.nameLabel.text = name
        }
    }
    
    func editEmail(email: String) {
        
        if !email.isEmpty {
            self.emailLabel.text = email
            
        }
    }
    
    func editPhone(phone: String) {
        
        if !phone.isEmpty {
            self.phoneLabel.text = phone
        }
    }
}
    

