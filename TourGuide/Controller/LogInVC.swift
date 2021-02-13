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
            emailView.layer.cornerRadius = emailView.frame.height / 2
        }
    }
    @IBOutlet weak var emailTF: UITextField! {
        didSet {
            emailTF.layer.cornerRadius = emailTF.frame.height / 2
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var passwordView: UIView! {
        didSet {
            passwordView.layer.cornerRadius = passwordView.frame.height / 2
        }
    }
    @IBOutlet weak var passwordTF: UITextField! {
        didSet {
            passwordTF.layer.cornerRadius = passwordTF.frame.height / 2
            passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var logInView: UIView! {
        didSet {
            logInView.layer.cornerRadius = logInView.frame.height / 2
        }
    }
    @IBOutlet weak var logInBtnOutlet: UIButton! {
        didSet {
            logInBtnOutlet.layer.cornerRadius = logInBtnOutlet.frame.height / 2
        }
    }
    @IBOutlet weak var googleView: UIView! {
        didSet {
            googleView.layer.cornerRadius = googleView.frame.height / 2
        }
    }
    @IBOutlet weak var googleLogInBtnOutlet: UIButton! {
    didSet {
        googleLogInBtnOutlet.layer.cornerRadius = googleLogInBtnOutlet.frame.height / 2
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
    
    @IBAction func skipBtnPressed(_ sender: UIButton) {
        
//        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HomeVC") as! HomeVC
//
//        homeVC.modalPresentationStyle = .fullScreen
//        present(homeVC, animated: true, completion: nil)
        
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController

        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true, completion: nil)
    }
    
    //MARK: -Helper functions

}

