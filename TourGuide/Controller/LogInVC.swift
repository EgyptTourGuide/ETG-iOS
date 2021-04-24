//
//  ViewController.swift
//  TourGuide
//
//  Created by samaa on 30/01/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInVC: UIViewController {

    
    //MARK: -IBOutlets
    @IBOutlet weak var rectangleImageView: UIImageView! 
    @IBOutlet weak var emailView: UIView! {
        didSet {
            emailView.layer.cornerRadius = emailView.frame.height / 2
        }
    }
    @IBOutlet weak var userNameTF: UITextField! {
        didSet {
            userNameTF.layer.cornerRadius = userNameTF.frame.height / 2
            userNameTF.attributedPlaceholder = NSAttributedString(string: "user name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
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
    
    @IBAction func logInBtnPressed(_ sender: UIButton) {
        
        if userNameTF.text == "" {
            //print("Please enter your email")
            showAlert(message: "Please enter your email")
            
            return
        }
        if passwordTF.text == "" {
            //passwordTF.placeholder =
            showAlert(message: "Please enter your password.")
            return
        }
        post_signin()
    }
    
    @IBAction func skipBtnPressed(_ sender: UIButton) {
        
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController

        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true, completion: nil)
    }
    
    //MARK: -Helper functions

    func post_signin() {
        
        startLoading()
        
        guard let url = URL(string: "https://egypttourguide.herokuapp.com/login") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let AlamoHeader = HTTPHeaders(header)
        
        let params: [String: AnyObject] = ["username": userNameTF.text,
                                     "password": passwordTF.text] as [String: AnyObject]
        
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AlamoHeader).responseJSON { (response) in
            
            self.dismiss(animated: true, completion: nil)

            switch response.result {
                
            case .success(_):
                
                let responseJSON = JSON(response.value as Any)
                //print(responseJSON)

                if responseJSON["id"].intValue != 0 {

                    let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController

                    mainTabBarController.modalPresentationStyle = .fullScreen
                    self.present(mainTabBarController, animated: true, completion: nil)
                }
                
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Error")
                self.showAlert(message: "email or password is wrong")
            }
        }
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func startLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
}

