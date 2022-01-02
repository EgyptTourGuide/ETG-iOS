//
//  SignUpVC.swift
//  TourGuide
//
//  Created by samaa on 03/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire
import ImagePicker

class SignUpVC: UIViewController {
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var userImageView: UIImageView! 
    
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
    let countryArr = ["Australia", "Canada", "China","Egypt", "Ireland", "Iceland","Palastine","Syria","United States", "United Kingdom"]
    
    let imageTapped = UITapGestureRecognizer()
    var profileImage: UIImage?
    var imgData: String?
    var name = ""
    var userName = ""
    var phone = ""
    var email = ""
    var country = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setImageTap()
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
        
        if !userNameTF.text!.isEmpty, !nameTF.text!.isEmpty, !phoneTF.text!.isEmpty, !emailTF.text!.isEmpty, !countryTF.text!.isEmpty, !passwordTF.text!.isEmpty {
            
            post_signuP()
        } else {
            showAlert(message: "Please enter all required data")
        }
    }
    
    @objc func imagePressed() {
        
        let imagePickerView = ImagePickerController()
        imagePickerView.imageLimit = 1
        imagePickerView.delegate = self
        
        self.present(imagePickerView, animated: true, completion: nil)
    }
    
    
    //MARK: -API Calls

    func post_signuP() {
        
        guard let url = URL(string: "\(offlineURL)/signup") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let AlamoHeader = HTTPHeaders(header)
        
        checkTFs()
        let params : [String : Any] = ["fullname":nameTF.text ?? "" ,
                                       "username":userNameTF.text ?? "",
                                       "email":emailTF.text ?? "",
                                       "password":passwordTF.text ?? "",
                                       //            "avatar":imgData ?? "",
                                       "phone":phoneTF.text ?? "",
                                       "country":countryTF.text ?? ""]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AlamoHeader).responseJSON { (response) in
            print(params)
            switch response.result {
                
            case .success(_):
                print(response.value ?? "")
                if response.response?.statusCode == 201 {
                    
                    self.dismiss(animated: true, completion: nil)
                }
                //print("SignUp \(response.response?.statusCode)")
                print("SignUp \(response.debugDescription)")
            case .failure(_):
                //print(response.debugDescription)
                print("SignUp \(response.error?.localizedDescription ?? "Error")")
                print("SignUp \(response.debugDescription)")
            }
        }
    }
    
    //MARK: -Helper functions
    func setImageTap() {
        
     userImageView.isUserInteractionEnabled = true
     userImageView.addGestureRecognizer(imageTapped)
     imageTapped.addTarget(self, action: #selector(self.imagePressed))
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func checkTFs() {
        if !nameTF.text!.isEmpty, userNameTF.text!.isEmpty, passwordTF.text!.isEmpty, countryTF.text!.isEmpty, nameTF.text!.isEmpty, !emailTF.text!.isEmpty {
            self.name = nameTF.text!
            self.userName = userNameTF.text!
            self.password = passwordTF.text!
            self.country = countryTF.text!
            self.email = emailTF.text!
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

extension SignUpVC: ImagePickerDelegate {
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        if images.count > 0 {
            profileImage = images.first
            userImageView.image = profileImage!.circleMasked
            self.imgData = stringFromImage(image: profileImage!)

        }
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
