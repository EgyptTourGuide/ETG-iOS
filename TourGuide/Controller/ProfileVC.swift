//
//  ProfileVC.swift
//  TourGuide
//
//  Created by samaa on 26/05/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var editBtnOutlet: UIButton! {
        didSet {
            editBtnOutlet.layer.cornerRadius = editBtnOutlet.frame.height / 2
        }
    }
    
    
    
    //MARK: -Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //getProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getProfile()
    }

    //MARK: - IBActions
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
        
        let editProfileVC = UIStoryboard(name:"Profile", bundle: nil).instantiateViewController(identifier: "EditProfVC") as EditProfVC
        
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LogInVC") as! LogInVC
        
        logInVC.modalPresentationStyle = .fullScreen
        present(logInVC, animated: true, completion: nil)
    }
    //MARK: -API Calls
    func getProfile() {
        
        guard let url = URL(string: "\(offlineURL)/profile") else {return}
        
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        //        print("Favorites \(alamoHeader!)")
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                
                switch response.result {
                    
                case .success(_):
                    
                    let repValue = response.value as AnyObject
                    //print("GetProfile success \(repValue)")
                    
                    self.userNameLabel.text = (repValue["username"] as! String)
                    self.nameLabel.text = (repValue["name"] as! String)
                    self.emailLabel.text = (repValue["email"] as! String)
                    self.countryLabel.text = (repValue["country"] as! String)
                    self.phoneLabel.text = (repValue["phone"] as! String)
                    
                case .failure(_):
                    
                    print(response.error?.localizedDescription ?? "Eroor: Failure")
                }
        }
        
    }
    
    //MARK: -Helper Functions
    

}
