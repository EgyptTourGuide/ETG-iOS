//
//  ConfirmDeclinePlanVC.swift
//  TourGuide
//
//  Created by samaa on 11/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class ConfirmDeclinePlanVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var placeIdLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var transportImageView: UIImageView!
    @IBOutlet weak var transportTypeLabel: UILabel!
    @IBOutlet weak var transportSeatsLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var driverPhoneLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var confirmBtnOutlet: UIButton! {
        didSet {
            confirmBtnOutlet.layer.cornerRadius = confirmBtnOutlet.frame.height / 2
        }
    }
    @IBOutlet weak var declineBtnOutlet: UIButton! {
        didSet {
            declineBtnOutlet.layer.cornerRadius = declineBtnOutlet.frame.height / 2
        }
    }
    
    
    //MARK: -Variables
    var planDetails: Dictionary<String,Any>?
    var planId = ""
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSecreenData()
        if let details = planDetails {
            id = (details["id"] as! String)
        }
    }
    
    //MARK: -IBActions
    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        confirmReservation()
    }
    
    @IBAction func declineBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: -API Calls
    func confirmReservation() {
          
          startLoading()
          
        guard let url = URL(string: "\(offlineURL)/plans/confirm") else {return}
        
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        let authorization = Constants().authHeader(authToken: APIToken)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        var params : [String : Any]?
        params = ["id": id]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
          .validate(statusCode: 200...300)
          .responseJSON { (response) in
              
            self.dismiss(animated: true, completion: nil)
            switch response.result {
                
            case .success(_):
                //print("Success")
                //print(response.value as Any)
                if response.response?.statusCode == 201 {
                    self.showAlert(message: "Creates")
                }
                    case .failure(_):
                print(response.error?.localizedDescription ?? "Error ")
                //print(response.debugDescription)
            }
        }
      }
    
    
    //MARK: -Helper functions
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Room"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setUpSecreenData() {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let details = planDetails {
            self.placeIdLabel.text = (details["id"] as! String)
            self.startDateLabel.text = (details["startDate"] as! String)
            self.endDateLabel.text = (details["endDate"] as! String)
            let transport = (details["transport"] as! Dictionary<String,Any>)
            let media = transport["media"] as! [String]
            self.transportImageView.image = getImage(from: (media[0]))
            self.transportTypeLabel.text = (transport["type"] as! String)
            self.transportSeatsLabel.text = "\(transport["seats"] as! Int)"
            self.driverNameLabel.text = (transport["driverName"] as! String)
            self.driverPhoneLabel.text = (transport["phone"] as! String)
            self.totalPriceLabel.text = (details["TotalPrice"] as! String)
        }
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
