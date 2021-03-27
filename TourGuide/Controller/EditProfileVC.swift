//
//  EditProfileVC.swift
//  TourGuide
//
//  Created by samaa on 21/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit


class EditProfileVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var confirmBtnOutlet: UIButton! {
        didSet {
            confirmBtnOutlet.layer.cornerRadius = confirmBtnOutlet.frame.height / 2
        }
    }
    
    
    
    //MARK: -Variables
    var delegate: EditProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
    }
    
    
    //MARK: -IBActions
    
    @IBAction func updateInfoBtnPressed(_ sender: UIButton) {
        
        //let profileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "ProfileVC") as! ProfileVC
        
        self.delegate?.editName(name: self.nameTF.text ?? "")
        self.delegate?.editEmail(email: self.emailTF.text ?? "")
        self.delegate?.editPhone(phone: self.phoneTF.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: -Helper Functions
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Edit Profile"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    
}


