//
//  ActivityVC.swift
//  TourGuide
//
//  Created by samaa on 26/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class ActivityVC: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var whereToDoCollectionView: UICollectionView!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var activityDescLabel: UILabel!
    
    
    
    @IBOutlet weak var addReviewBtnOutlet: UIButton! {
        didSet {
            addReviewBtnOutlet.layer.cornerRadius = addReviewBtnOutlet.frame.height / 2
        }
    }
    //MARK: -Variables
    var activityId = ""
    var getPlaceArr = [GetPlace]()
    var placeImagesArr = [String]()
    var selectedCityId = ""
    var activityName = ""

    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        get_activityDetails()
        get_places()
        print(activityName)
    }
    
    
    //MARK: -IBActions
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        
    }
    
    //MARK: -API Calls
    func get_activityDetails() {
        
        guard let url = URL(string: "\(offlineURL)/activity/\(activityId)") else {return}
        
        //print(url)
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                
                let repValue = response.value as? Dictionary<String,AnyObject>
                let activity = repValue!["activity"] as? Dictionary<String,AnyObject>
                //print(hotel)
                
                let getActivityDetails = GetActivity(activity: (activity)!)
                self.activityNameLabel.text = getActivityDetails.name
                self.activityDescLabel.text = getActivityDetails.descreption
                self.activityImageView.image = getImage(from: getActivityDetails.media![0])
                
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Error: Failure")
            }
        }
    }
    
    func get_places() {
        
        guard let url = URL(string: "\(offlineURL)/places?tag=\(activityName)") else {return}
        
        //print(url)
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                
                let repValue = response.value as? Dictionary<String,AnyObject>
                let places = repValue!["places"] as? [Dictionary<String,AnyObject>]
                //print("Places: \(places!)")
                
                for place in places! {
                    
                    let getPlace = GetPlace(places: place)
                    self.getPlaceArr.append(getPlace)
                    self.placeImagesArr.append(getPlace.media![0])
                    print(getPlace.name!)
                }
                
                self.whereToDoCollectionView.reloadData()
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Eroor: Failure")
            }
        }
    }
    //MARK: -Helper Functions
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Activity"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    

}


extension ActivityVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reviewsTableView.dequeueReusableCell(withIdentifier: "CommentsTVCell", for: indexPath) as! CommentsTVCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return reviewsTableView.frame.height
    }
    
}


extension ActivityVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return getPlaceArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = whereToDoCollectionView.dequeueReusableCell(withReuseIdentifier: "CityPlacesCVCell", for: indexPath) as! CityPlacesCVCell

        cell.placeHDNameLabel.text = getPlaceArr[indexPath.row].name
        cell.placHDImageView.image = getImage(from: placeImagesArr[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let cityVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "CityVC") as! CityVC
//        
//        if let cityId = getCityArr[indexPath.row].id {
//            
//            self.selectedCityId = cityId
//            //print("selected \(selectedCityId)")
//        }
//        
//        //print(selectedCityId)
//        cityVC.cityId = selectedCityId
//        
//        self.navigationController?.pushViewController(cityVC, animated: true)
        
    }
    
}
