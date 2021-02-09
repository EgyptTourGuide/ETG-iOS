//
//  SignUpVC.swift
//  TourGuide
//
//  Created by samaa on 03/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var nameTF: UITextField! {
        didSet {
            nameTF.layer.cornerRadius = 15
            nameTF.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var emailTF: UITextField! {
        didSet {
            emailTF.layer.cornerRadius = 15
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var countryView: UIView! {
        didSet {
            //countryView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var countryTF: UITextField! {
        didSet {
            countryTF.attributedPlaceholder = NSAttributedString(string: "Country", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var chooseCountryBtnOutlet: UIButton!
    @IBOutlet weak var phoneTF: UITextField! {
        didSet {
            phoneTF.layer.cornerRadius = 15
            phoneTF.attributedPlaceholder = NSAttributedString(string: "Phone number", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var passwordTF: UITextField! {
        didSet {
            passwordTF.layer.cornerRadius = 15
            passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var confirmPasswordTF: UITextField! {
        didSet {
            confirmPasswordTF.layer.cornerRadius = 15
            confirmPasswordTF.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var registerBtnOutlet: UIButton! {
        didSet {
            registerBtnOutlet.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var googleView: UIView! {
        didSet {
            googleView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var googleBtnOutlet: UIButton! {
        didSet {
            googleBtnOutlet.layer.cornerRadius = 15
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: -IBActions
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
//        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LogInVC") as! LogInVC
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: -Helper functions

}
