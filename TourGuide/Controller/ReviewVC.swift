//
//  ReviewVC.swift
//  TourGuide
//
//  Created by samaa on 14/04/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import SwiftyJSON

class ReviewVC: UIViewController {

    //MARK: -Outlets
    @IBOutlet var quesBackView: [UIView]! {
        didSet {
            for quesView in quesBackView {
                quesView.layer.cornerRadius = 10
            }
        }
    }

    @IBOutlet var questionsLabelsCollection: [UILabel]! {
        didSet {
            for question in 0..<questionsLabelsCollection.count {
                questionsLabelsCollection[question].text = questionsArr[question]
            }
        }
    }
    
    
    
    @IBOutlet weak var commentTF: UITextField!
    
    @IBOutlet weak var commentView: UIView! {
        didSet {
            commentView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var submitBtnOutlet: UIButton! {
        didSet {
            submitBtnOutlet.layer.cornerRadius = submitBtnOutlet.frame.height / 4
        }
    }
    
    @IBOutlet weak var yesBtnOutlet1: UIButton!
    @IBOutlet weak var yesBtnOutlet2: UIButton!
    @IBOutlet weak var yesBtnOutlet3: UIButton!
    @IBOutlet weak var yesBtnOutlet4: UIButton!
    @IBOutlet weak var noBtnOutlet1: UIButton!
    @IBOutlet weak var noBtnOutlet2: UIButton!
    @IBOutlet weak var noBtnOutlet3: UIButton!
    @IBOutlet weak var noBtnOutlet4: UIButton!
    @IBOutlet weak var cosmosView: CosmosView!
    
    
    
    //MARK: -Variables
    var questionsArr = [String]()
    var answer1 = true
    var answer2 = true
    var answer3 = true
    var answer4 = true
    var answers = [Bool]()
    var rate = 0.0
    var placeId = ""
    var comment = ""
    var hotelId = ""
    var planId = ""
    var id = ""
    
    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        getCosmos()
        
    }

    //MARK: -IBActions
    @IBAction func yesOrNoBtnPressed(_ sender: UIButton) {
        
        let num = sender.tag
        
        switch num {
        case 1...2:
            if sender == noBtnOutlet1 {
                answer1 = false
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                yesBtnOutlet1.isEnabled = false
            } else {
                answer1 = true
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                noBtnOutlet1.isEnabled = false
            }
            answers.append(answer1)
            break
            case 3...4:
            if sender == noBtnOutlet2 {
                answer2 = false
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                yesBtnOutlet2.isEnabled = false
            } else {
                answer2 = true
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                noBtnOutlet2.isEnabled = false
            }
            answers.append(answer2)
            
        case 5...6:
            if sender == noBtnOutlet3 {
                answer3 = false
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                yesBtnOutlet3.isEnabled = false
            } else {
                answer3 = true
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                noBtnOutlet3.isEnabled = false
            }
            answers.append(answer3)
            
            case 7...8:
            if sender == noBtnOutlet4 {
                answer4 = false
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                yesBtnOutlet4.isEnabled = false
            } else {
                answer4 = true
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                noBtnOutlet4.isEnabled = false
            }
            answers.append(answer4)
        default:
            return
        }
        //print(answers)
    }
    
    @IBAction func submitReviewBtnPressed(_ sender: UIButton) {
        
        
        if id == placeId {
            post_review()
        } else if id == hotelId {
            post_reviewHotel()
        } else if id == planId {
            post_reviewPlan()
        }
        
    }
    
    
    //MARK: -API Calls
    
    func post_reviewHotel() {
            
            startLoading()
            
            guard let url = URL(string: "\(offlineURL)/hotels/\(hotelId)/review") else {return}
            
            print(url)
            let header = Constants().defaultHeader
            let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
    //        print("getFavToken: \(APIToken)")
            let authorization = Constants().authHeader(authToken: APIToken)
    //        print(header, authorization)
            let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
            print(alamoHeader!)
                    //print(answers, rate, commentTF.text ?? "")
            
            ckeckCommentTF()
            
            let params : [String : Any] = ["answers": answers,
                                           "rate": rate,
                                           "comment": comment]
           
            print(answers, rate, commentTF.text as Any)
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
                .validate(statusCode: 200...300)
                .responseJSON { (response) in
                    
                    self.dismiss(animated: true, completion: nil)
                    switch response.result {
                        
                    case .success(_):
                        print("Success")
                        print(response.value ?? "")
                        if response.response?.statusCode == 201 {
                            self.showAlert(message: "Created")
                        }
                    case .failure(_):
                        print(response.error?.localizedDescription ?? "Error ")
                        print(response.debugDescription)
                        //self.showAlert(message: "You should answer the 4 qustions, your rate, and write a comment")
                }
            }
        }
        
    func post_review() {
        
        startLoading()
        
        guard let url = URL(string: "\(offlineURL)/places/\(placeId)/review") else {return}
        
        print(url)
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
//        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
//        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        print(alamoHeader!)
                //print(answers, rate, commentTF.text ?? "")
        
        ckeckCommentTF()
        
        let params : [String : Any] = ["answers": answers,
                                       "rate": rate,
                                       "comment": comment]
       
        print(answers, rate, commentTF.text as Any)
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                
                self.dismiss(animated: true, completion: nil)
                switch response.result {
                    
                case .success(_):
                    print("Success")
                    print(response.value ?? "")
                    if response.response?.statusCode == 201 {
                        self.showAlert(message: "Created")
                    }
                case .failure(_):
                    print(response.error?.localizedDescription ?? "Error ")
                    print(response.debugDescription)
                    //self.showAlert(message: "You should answer the 4 qustions, your rate, and write a comment")
            }
        }
    }
    
    func post_reviewPlan() {
            
            startLoading()
            
            guard let url = URL(string: "\(offlineURL)/plans/\(planId)/review") else {return}
            
            print(url)
            let header = Constants().defaultHeader
            let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
    //        print("getFavToken: \(APIToken)")
            let authorization = Constants().authHeader(authToken: APIToken)
    //        print(header, authorization)
            let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
            print(alamoHeader!)
                    //print(answers, rate, commentTF.text ?? "")
            
            ckeckCommentTF()
            
            let params : [String : Any] = ["answers": answers,
                                           "rate": rate,
                                           "comment": comment]
           
            print(answers, rate, commentTF.text as Any)
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
                .validate(statusCode: 200...300)
                .responseJSON { (response) in
                    
                    self.dismiss(animated: true, completion: nil)
                    switch response.result {
                        
                    case .success(_):
                        print("Success")
                        print(response.value ?? "")
                        self.showAlert(message: "Created")

                    case .failure(_):
                        print(response.error?.localizedDescription ?? "Error ")
                        print(response.debugDescription)
                        self.showAlert(message: "You should answer the 4 qustions, your rate, and write a comment")
                }
            }
        }
    //MARK: -Helper Functions
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Review"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }


    func getCosmos() {
        
        cosmosView.didTouchCosmos = { rating in
            //print("rate: \(rating) ")
            self.rate = rating
        }
        
        cosmosView.settings.fillMode = .precise
        
    }
    
    func ckeckCommentTF() {
        if !commentTF.text!.isEmpty {
            self.comment = commentTF.text!
        } else {
            self.showAlert(message: "You should write a comment")
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



