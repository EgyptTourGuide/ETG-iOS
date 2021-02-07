//
//  ViewController.swift
//  TourGuide
//
//  Created by samaa on 30/01/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    
    //MARK: -IBOutlets
    @IBOutlet weak var rectangleImageView: UIImageView! 
    @IBOutlet weak var emailView: UIView! {
        didSet {
            emailView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var emailTF: UITextField! {
        didSet {
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var passwordView: UIView! {
        didSet {
            passwordView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var passwordTF: UITextField! {
        didSet {
            passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var logInView: UIView! {
        didSet {
            logInView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var logInBtnOutlet: UIButton! {
        didSet {
            logInBtnOutlet.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var googleView: UIView! {
        didSet {
            googleView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var googleLogInBtnOutlet: UIButton! {
    didSet {
        googleLogInBtnOutlet.layer.cornerRadius = 15
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //MARK: -IBActions
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        
        let signUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
    }
    
    
    //MARK: -Helper functions

}

