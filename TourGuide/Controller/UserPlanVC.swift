//
//  UserPlanVC.swift
//  TourGuide
//
//  Created by samaa on 12/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class UserPlanVC: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var planImageView: UIImageView!
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var personsNumLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var transportImageView: UIImageView!
    @IBOutlet weak var hotelNameLabdel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var driverPhoneLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var roomsCollectionView: UICollectionView!
    @IBOutlet weak var alertView: UIView! {
        didSet {
            alertView.isHidden = true
            alertView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var alertLabel: UILabel!
    
    //MARK: -Variables
    var roomImgsArr = [String]()
    var roomStatusArr = [String]()
    var roomPriceArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getPlans()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getPlans()
    }
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
                            self.cityNameLabel.text = (city["name"] as! String)
                            let userPlan = plan["plan"] as! Dictionary<String,Any>
                            let pmedia = userPlan["media"] as! [String]
                            self.planImageView.image = getImage(from: pmedia[0])
                            self.planNameLabel.text = (userPlan["title"] as! String)
                            self.priceLabel.text = (plan["price"] as! String)
                            self.personsNumLabel.text = (plan["persons"] as! String)
                            //                        let duration = plan["duration"] as! Dictionary<String,Any>
                            //                        self.daysLabel.text = "\(duration["days"] as! String)"
                            //                        self.hoursLabel.text = "\(duration["hours"] as! String)"
                            let transport = plan["transport"] as! Dictionary<String,Any>
                            self.driverNameLabel.text = (transport["driver"] as! String)
                            self.driverPhoneLabel.text = (transport["phone"] as! String)
                            self.seatsLabel.text = "\(transport["seats"] as! Int)"
                            let transmedia = (transport["media"] as! [String])
                            self.transportImageView.image = getImage(from: transmedia[0])
                        }
                    } else {
                        self.alertView.isHidden = false
                            self.alertLabel.text = "There is no plan"
                        }
                        
                        let hotels = repValue["hotels"] as! [Dictionary<String,Any>]
                        if hotels.count > 0 {
                            for h in hotels {
                                let hotel = h["hotel"] as! Dictionary<String,Any>
                                self.hotelNameLabdel.text = (hotel["name"] as! String)
                                self.hotelImageView.image = getImage(from: (hotel["media"] as! String))
                                let rooms = hotel["rooms"] as! [Dictionary<String,Any>]
                                for room in rooms {
                                    self.roomStatusArr.append(room["status"] as! String)
                                    //                            self.roomPriceArr.append(room["price"] as! String)
                                    let media = room["media"] as! [String]
                                    self.roomImgsArr.append(media[0])
                                }
                            }
                        } else {
                            self.alertView.isHidden = false
                            self.alertLabel.text = "There is no hotel"
                        }
                     
                    
                    if plans.count == 0 && hotels.count == 0 {
                        self.alertView.isHidden = false
                        self.alertLabel.text = "There is no plan or hotel"
                    }
                    self.roomsCollectionView.reloadData()
                
                case .failure(_):
                    print(response.error?.localizedDescription ?? "Eroor: Failure")
                }
        }
        
    }

}


extension UserPlanVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomImgsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = roomsCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomPlanCVCell", for: indexPath) as! RoomPlanCVCell
        cell.roomImageView.image = getImage(from: roomImgsArr[indexPath.row])
//        cell.roomPriceLabel.text = roomPriceArr[indexPath.row]
        cell.roomStatusLabel.text = roomStatusArr[indexPath.row]
        return cell
    }
    
}
