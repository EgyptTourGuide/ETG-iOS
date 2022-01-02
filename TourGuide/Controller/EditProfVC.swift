//
//  EditProfileVC.swift
//  TourGuide
//
//  Created by samaa on 21/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditProfVC: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    @IBOutlet weak var confirmBtnOutlet: UIButton! {
        didSet {
            confirmBtnOutlet.layer.cornerRadius = confirmBtnOutlet.frame.height / 2
        }
    }
    
    
    
    //MARK: -Variables
    var name = ""
    var country = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
    }
    
    
    //MARK: -IBActions
    
    
    
    @IBAction func updateInfoBtnPressed(_ sender: UIButton) {
        
        if !nameTF.text!.isEmpty {
            postName()
        }
        if !phoneTF.text!.isEmpty {
            postPhone()
        }
        if !countryTF.text!.isEmpty {
            postCountry()
        }
        if !passwordTF.text!.isEmpty && !confirmPassTF.text!.isEmpty {
            if passwordTF.text == confirmPassTF.text {
                postPassword()
            } else {
                showAlert(message: "confirm password and password must be the same")
            }
        }
    }
    
    
    //MARK: -API Calls
    func postName() {
        
        //startLoading()
        
        guard let url = URL(string: "\(offlineURL)/profile") else {return}
        
        print(url)
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        
        
        let params: [String: AnyObject] = ["fullname": nameTF.text!] as [String: AnyObject]
        
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                
                //self.dismiss(animated: true, completion: nil)
                
                switch response.result {
                    
                case .success(_):
                    
                    let responseJSON = JSON(response.value as Any)
                    print("postName: \(responseJSON)")
                    
                case .failure(_):
                    
                    print(response.error?.localizedDescription ?? "Error")
                    //self.showAlert(message: "Write correct data")
                }
        }
    }
    
    func postPhone() {
        
        //startLoading()
        
        guard let url = URL(string: "\(offlineURL)/profile") else {return}
        
        print(url)
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        let params: [String: AnyObject] = ["phone": phoneTF.text!] as [String: AnyObject]
        
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                
                //self.dismiss(animated: true, completion: nil)
                
                switch response.result {
                    
                case .success(_):
                    
                    let responseJSON = JSON(response.value as Any)
                    print("postPhone: \(responseJSON)")
                    
                case .failure(_):
                    
                    print(response.error?.localizedDescription ?? "Error")
                    //self.showAlert(message: "Write correct data")
                }
        }
    }
    
    func postCountry() {
        
        //startLoading()
        
        guard let url = URL(string: "\(offlineURL)/profile") else {return}
        
        print(url)
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        let params: [String: AnyObject] = ["country": countryTF.text!] as [String: AnyObject]
        
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                
                //self.dismiss(animated: true, completion: nil)
                
                switch response.result {
                    
                case .success(_):
                    
                    let responseJSON = JSON(response.value as Any)
                    print("postCountry: \(responseJSON)")
                    
                    
                case .failure(_):
                    
                    print(response.error?.localizedDescription ?? "Error")
                    //self.showAlert(message: "Write correct data")
                }
        }
    }
    
    func postPassword() {
        
        //startLoading()
        
        guard let url = URL(string: "\(offlineURL)/profile") else {return}
        
        print(url)
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        let params: [String: AnyObject] = ["password": passwordTF.text!] as [String: AnyObject]
        
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                
                //self.dismiss(animated: true, completion: nil)
                
                switch response.result {
                    
                case .success(_):
                    
                    let responseJSON = JSON(response.value as Any)
                    //print(responseJSON)
                    
                    if responseJSON["id"].intValue != 0 {
                        
                        
                    }
                    
                    
                case .failure(_):
                    
                    print(response.error?.localizedDescription ?? "Error")
                    //self.showAlert(message: "Write correct data")
                }
        }
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
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
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


