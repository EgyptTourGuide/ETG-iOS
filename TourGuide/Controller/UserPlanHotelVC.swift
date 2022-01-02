//
//  UserPlanHotelVC.swift
//  TourGuide
//
//  Created by samaa on 12/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class UserPlanHotelVC: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLAbel: UILabel!
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var planCollectionView: UICollectionView!
   
    @IBOutlet weak var hotelCollectionView: UICollectionView!
    
    //MARK: -Variables
    var plansImageArr = [String]()
    var plansnameArr = [String]()
    var planspriceArr = [String]()
    var planspersonsArr = [String]()
    var hotelsNameArr = [String]()
    var hotelImagesArr = [String]()
    var plan: Dictionary<String,Any>?
    var rooms = [Dictionary<String,Any>]()
    var planId = ""
    var questionsArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getPlans()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    //MARK: -IBActions

    
    
    //MARK: -API Calls
    func getPlans() {
        
        guard let url = URL(string: "\(offlineURL)/profile/plans") else {return}
        
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: alamoHeader)
            .responseJSON { (response) in
                switch response.result {
                    
                case .success(_):
                    
                    print("Success")
                    
                    //print(response.value)
                    let repValue = response.value as! Dictionary<String,Any>
                    let plans = repValue["plans"] as! [Dictionary<String,Any>]
                    
                    if plans.count > 0 {
                        for plan in plans {
                            let city = plan["city"] as! Dictionary<String,Any>
                            let media = city["media"] as! [String]
                            self.cityImageView.image = getImage(from: media[0])
                            self.cityNameLAbel.text = (city["name"] as! String)
                            let userPlan = plan["plan"] as! Dictionary<String,Any>
                            let pmedia = userPlan["media"] as! [String]
                            self.plansnameArr.append(userPlan["title"] as! String)
                            self.plansImageArr.append(pmedia[0])
                            self.planspriceArr.append("\(plan["price"] as! String)")
                            self.planspersonsArr.append("\(plan["persons"] as! String) persons")
                            self.plan = plan
                            self.planId = (plan["id"] as! String)
                        }
                        
                    }
                    
                    let hotels = repValue["hotels"] as! [Dictionary<String,Any>]
                    if hotels.count > 0 {
                        for h in hotels {
                            let hotel = h["hotel"] as! Dictionary<String,Any>
                            self.hotelsNameArr.append(hotel["name"] as! String)
                            self.hotelImagesArr.append((hotel["media"] as! String))
                            print(hotel["rooms"] as Any)
                            self.rooms = hotel["rooms"] as! [Dictionary<String,Any>]

                        }
                    }
                    
                    self.planCollectionView.reloadData()
                    self.hotelCollectionView.reloadData()
                    
                case .failure(_):
                    print(response.error?.localizedDescription ?? "Eroor: Failure")
                }
        }
        
        
        
    }
    
}


extension UserPlanHotelVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == planCollectionView {
            return plansnameArr.count
        } else  {
            return hotelsNameArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == planCollectionView {
            let cell = planCollectionView.dequeueReusableCell(withReuseIdentifier: "UserPlanCVCell", for: indexPath) as! UserPlanCVCell
            
            cell.planImageView.image = getImage(from: plansImageArr[indexPath.row])
            cell.planNameLabel.text = plansnameArr[indexPath.row]
            cell.planPriceLabel.text = planspriceArr[indexPath.row]
            cell.planPersonsLabel.text = planspersonsArr[indexPath.row]
            return cell
        } else {
            
            let cell = hotelCollectionView.dequeueReusableCell(withReuseIdentifier: "UserHotelCVCell", for: indexPath) as! UserHotelCVCell
            
            cell.hotelImageView.image = getImage(from: hotelImagesArr[indexPath.row])
            cell.hotelNameLabel.text = hotelsNameArr[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == planCollectionView {
            
            let planDetailsVC = UIStoryboard(name: "AddNewPlane", bundle: nil).instantiateViewController(identifier: "PlanDetailsVC") as! PlanDetailsVC
            
            planDetailsVC.plan = self.plan
            self.navigationController?.pushViewController(planDetailsVC, animated: true)
        } else if collectionView == hotelCollectionView {
            
            let planRoomVC = UIStoryboard(name: "AddNewPlane", bundle: nil).instantiateViewController(identifier: "PlanRoomVC") as! PlanRoomVC
            
            planRoomVC.rooms = self.rooms
            self.navigationController?.pushViewController(planRoomVC, animated: true)
        }
    }
}

