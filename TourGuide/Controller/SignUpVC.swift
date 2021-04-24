//
//  SignUpVC.swift
//  TourGuide
//
//  Created by samaa on 03/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class SignUpVC: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var nameTF: UITextField! {
        didSet {
            nameTF.layer.cornerRadius = nameTF.frame.height / 2
            nameTF.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var userNameTF: UITextField! {
        didSet {
            userNameTF.layer.cornerRadius = userNameTF.frame.height / 2
            userNameTF.attributedPlaceholder = NSAttributedString(string: "User name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var countryView: UIView! {
        didSet {
            //countryView.layer.cornerRadius = countryView.frame.height / 2
        }
    }
    @IBOutlet weak var countryTF: UITextField! {
        didSet {
            //phoneTF.layer.cornerRadius = countryTF.frame.height / 2
            countryTF.attributedPlaceholder = NSAttributedString(string: "Country", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var chooseCountryBtnOutlet: UIButton!
    @IBOutlet weak var phoneTF: UITextField! {
        didSet {
            phoneTF.layer.cornerRadius =  phoneTF.frame.height / 2
            phoneTF.attributedPlaceholder = NSAttributedString(string: "Phone number", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var emailTF: UITextField! {
        didSet {
            emailTF.layer.cornerRadius = emailTF.frame.height / 2
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
   
    @IBOutlet weak var passwordTF: UITextField! {
        didSet {
            passwordTF.layer.cornerRadius = passwordTF.frame.height / 2
            passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var registerBtnOutlet: UIButton! {
        didSet {
            registerBtnOutlet.layer.cornerRadius = registerBtnOutlet.frame.height / 2
        }
    }
    @IBOutlet weak var googleView: UIView! {
        didSet {
            googleView.layer.cornerRadius = googleView.frame.height / 2
        }
    }
    @IBOutlet weak var googleBtnOutlet: UIButton! {
        didSet {
            googleBtnOutlet.layer.cornerRadius = googleBtnOutlet.frame.height / 2
        }
    }
    
    @IBOutlet weak var countryPicker: UIPickerView! {
        didSet {
            countryPicker.isHidden = true
        }
    }
    
    
    //MARK: -Variables
    let countryArr = ["Australia", "Canada", "China","Egypt","Iceland","Palastine","Syria","United States", "United Kingdom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: -IBActions
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
//        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LogInVC") as! LogInVC
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showHidePicker(_ sender: UIButton) {
        
        if  countryPicker.isHidden {
            countryPicker.isHidden = false
        }else {
            countryPicker.isHidden = true
        }
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        post_signuP()
    }
    
    //MARK: -Helper functions

    func post_signuP() {
        
        guard let url = URL(string: "https://egypttourguide.herokuapp.com/signup") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let AlamoHeader = HTTPHeaders(header)
        
        let params : [String : Any] = ["fullname":nameTF.text ?? "",
                                       "username":userNameTF.text ?? "",
                                       "email":emailTF.text ?? "",
                                       "password":passwordTF.text ?? "",
                                       "phone":phoneTF.text ?? "",
                                       "country":countryTF.text ?? ""]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AlamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                print(response.value ?? "")
                
                let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController

                mainTabBarController.modalPresentationStyle = .fullScreen
                self.present(mainTabBarController, animated: true, completion: nil)
                
            case .failure(_):
                print(response.error?.localizedDescription ?? "Error ")
            }
        }
    }
    
    
    
}



extension SignUpVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArr.count
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = countryArr[row]
        countryTF.text = selectedCountry
        
        countryPicker.isHidden = true
    }
    
    
}
