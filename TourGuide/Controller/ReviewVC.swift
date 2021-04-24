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
    
    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        getCosmos()
    }

    //MARK: -IBActions
    @IBAction func yesOrNoBtnPressed(_ sender: UIButton) {
        
        var num = sender.tag
        
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
        print(answers)
    }
    
    @IBAction func submitReviewBtnPressed(_ sender: UIButton) {
        post_review()
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
            print("rate: \(rating) ")
            self.rate = rating
        }
        
        cosmosView.settings.fillMode = .precise
        
    }
    
    func post_review() {
        
        guard let url = URL(string: "https://egypttourguide.herokuapp.com/places/\(placeId)/review") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let AlamoHeader = HTTPHeaders(header)
        
        print(answers, rate, commentTF.text ?? "")
        let params : [String : Any] = ["answers": answers,
                                       "rate": rate,
                                       "comment": commentTF.text ?? ""]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AlamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                print("Success")
                print(response.value ?? "")
                
            case .failure(_):
                print(response.error?.localizedDescription ?? "Error ")
            }
        }
    }
}



