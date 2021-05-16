//
//  PlaceDetailsVC.swift
//  TourGuide
//
//  Created by samaa on 11/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class PlaceDetailsVC: UIViewController {

    //MARK: -IBOutlets
    
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = searchView.frame.height / 2
        }
    }
    
    @IBOutlet weak var searchTf: UITextField! {
        didSet {
            searchTf.layer.cornerRadius = searchTf.frame.height / 2
            searchTf.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    
    @IBOutlet weak var addReviewBtnOutlet: UIButton! {
        didSet {
            addReviewBtnOutlet.layer.cornerRadius = addReviewBtnOutlet.frame.height / 2
        }
    }
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var mapImageBackView: UIView! {
        didSet {
            mapImageBackView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var commentsTableView: UITableView! {
        didSet {
            commentsTableView.layer.borderWidth = 2
            commentsTableView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            commentsTableView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var desriptionLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    
    //MARK: -Variables
    var placeId = ""
    var questionsArr = [String]()
    var daysArr = [String]()
    var fromArr = [String]()
    var toArr = [String]()
    var hoursArr = [String]()
    var commentsArr = [String]()
    var reviewerNames = [String]()
    var reviewerPictures = [String]()


    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        print(placeId)
        get_placeDetails()
    }
    


    //MARK: -IBActions
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        
        let reviewVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "ReviewVC") as! ReviewVC
        
        reviewVC.questionsArr = self.questionsArr
        reviewVC.placeId = self.placeId
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    
   
    
    
    //MARK: -Helper Functions
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Place"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func get_placeDetails() {

        guard let url = URL(string: "https://egypttourguide.herokuapp.com/places/\(placeId)") else {return}

        print(url)
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in

            switch response.result {

            case .success(_):

                let repValue = response.value as? Dictionary<String,AnyObject>
                let place = repValue!["place"] as? Dictionary<String,AnyObject>
                let getPlaceDetails = GetPlaceDetails(place: place!)
                //print("Place: \(place!)")
                
                self.placeLabel.text = getPlaceDetails.name
                self.rateLabel.text = "\(getPlaceDetails.rate ?? 0)"
                self.desriptionLabel.text = getPlaceDetails.description
                self.placeImageView.image = getImage(from: getPlaceDetails.media![0])
                
                self.questionsArr = getPlaceDetails.questions!
                //print(self.questionsArr)
                
                let hours = getPlaceDetails.hours
                for hour in hours {
                    
                    self.daysArr.append(hour["day"] as! String)
                    self.fromArr.append(hour["from"] as! String)
                    self.toArr.append(hour["to"] as! String)
                    
                }
                
                for day in 0..<self.daysArr.count {
                    self.hoursArr.append("\(self.daysArr[day]), from \(self.fromArr[day]) to \(self.toArr[day]) \n")
                    
                }
                
                //let the array of strings "hours" be one string
                let joined = self.hoursArr.joined()
                self.hourLabel.text = joined
                //print(self.daysArr, self.fromArr, self.toArr)
                //print(getPlaceDetails.hours)
                
                let reviews = getPlaceDetails.reviews
                for review in reviews {
                    
                    self.commentsArr.append(review["comment"] as! String)
                    //print(review["user"] as Any)
                    let reviewer = review["user"] as! Dictionary<String,Any>
                    self.reviewerNames.append(reviewer["name"] as! String)
                    self.reviewerPictures.append(reviewer["picture"] as! String)
                    }
                
                self.commentsTableView.reloadData()
                //print(getPlaceDetails.reviews)
                
            case .failure(_):

                print(response.error?.localizedDescription ?? "Error: Failure")
            }
        }
    }

    
}


extension PlaceDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commentsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "CommentsTVCell", for: indexPath) as! CommentsTVCell
        cell.commentLabel.text = commentsArr[indexPath.row]
        cell.nameLabel.text = reviewerNames[indexPath.row]
        cell.profileImage.image = getImage(from: reviewerPictures[indexPath.row])?.circleMasked
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return commentsTableView.frame.height
    }
    
}
