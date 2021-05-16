//
//  HomeVC.swift
//  TourGuide
//
//  Created by samaa on 08/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var searchTF: UITextField! {
        didSet {
            searchTF.layer.cornerRadius = searchTF.frame.height / 2
            searchTF.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = searchView.frame.height / 2
        }
    }
    @IBOutlet weak var recomndedCollectionView: UICollectionView!
    @IBOutlet weak var cityAdvenCollectionView: UICollectionView!
    
    @IBOutlet weak var citiesBtnOutlet: UIButton!
    @IBOutlet weak var adventuresBtnOutlet: UIButton!
    @IBOutlet weak var chooseCityAdvCollectionView: UICollectionView!
    
    
    //MARK: -Variables
    let recomendedImagesArray = [#imageLiteral(resourceName: "divingHomePhoto"), #imageLiteral(resourceName: "desertSafariHome"), #imageLiteral(resourceName: "divingHomePhoto"), #imageLiteral(resourceName: "desertSafariHome"), #imageLiteral(resourceName: "divingHomePhoto")]
    var cityAdvenImagesArray = [String]()
    let labelsArray = ["Cities", "Adventures"]
    var getCityArr = [GetCity]()
    var cityImagesArr = [String]()
    var selectedCityId = ""
    var getActiviyIdArr = [String]()
    var getActiviyNamesArr = [String]()
    var ActiviyImagesArr = [String]()
    
    //MARK: -View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_cities()
        get_activities()
    }
    

    //MARK: -IBActions
    
    
    //MARK: -Helper functions

    func get_cities() {
        
        guard let url = URL(string: "https://egypttourguide.herokuapp.com/cities") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                
                let repValue = response.value as? Dictionary<String,AnyObject>
                let cities = repValue!["cities"] as? [Dictionary<String,AnyObject>]
                //print(cities)
                
                for city in cities! {
                    
                    let getCity = GetCity(cities: city)
                    self.getCityArr.append(getCity)
                    self.cityImagesArr.append(getCity.media![0])
                    
                }
                
                self.cityAdvenCollectionView.reloadData()
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Error")
            }
        }
    }
    
    func get_activities() {
        
        guard let url = URL(string: "https://egypttourguide.herokuapp.com/activity") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                
                let repValue = response.value as! [AnyObject]
                //print(repValue)
                
                for activity in repValue {
                    
                    let getActivity = GetActivity(activity: activity as! Dictionary<String, Any>)
                    self.getActiviyIdArr.append(getActivity.id!)
                    self.getActiviyNamesArr.append(getActivity.name!)
                    self.ActiviyImagesArr.append(getActivity.media![0])
                    
                }
                                
                self.cityAdvenCollectionView.reloadData()
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Error")
            }
        }
    }
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == recomndedCollectionView {
            return recomendedImagesArray.count
            
        } else if collectionView == chooseCityAdvCollectionView {
            return labelsArray.count
            
        } else {
            return cityAdvenImagesArray.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recomndedCollectionView {
            
            let cell = recomndedCollectionView.dequeueReusableCell(withReuseIdentifier: "RecomendedCVCell", for: indexPath) as! RecomendedCVCell
            cell.recomndedImageView.image = recomendedImagesArray[indexPath.row]
            return cell
            
        } else if collectionView == cityAdvenCollectionView {
            
            let cell = cityAdvenCollectionView.dequeueReusableCell(withReuseIdentifier: "CityAdvenCVCell", for: indexPath) as! CityAdvenCVCell
            
            if cityAdvenImagesArray == cityImagesArr {
                
                cell.cityAdvenLabel.text = getCityArr[indexPath.row].name
                cell.cityAdvenImageView.image = getImage(from: cityImagesArr[indexPath.row])
                
            } else if cityAdvenImagesArray == ActiviyImagesArr {
                
                cell.cityAdvenLabel.text = getActiviyNamesArr[indexPath.row]
                cell.cityAdvenImageView.image = getImage(from: ActiviyImagesArr[indexPath.row])
            }
            
            
            return cell
            
        } else {
            
            let cell = chooseCityAdvCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseProFavCVCell", for: indexPath) as! ChooseProFavCVCell
            
            cell.cellLabel.text = labelsArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == cityAdvenCollectionView {
            
            if cityAdvenImagesArray == cityImagesArr {
                let cityVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "CityVC") as! CityVC
                
                if let cityId = getCityArr[indexPath.row].id {
                    
                    self.selectedCityId = cityId
                    print("selected \(selectedCityId)")
                }
                
                print(selectedCityId)
                cityVC.cityId = selectedCityId
                
                self.navigationController?.pushViewController(cityVC, animated: true)
                
            } else if cityAdvenImagesArray == ActiviyImagesArr {
                
                let activityVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "ActivityVC") as! ActivityVC
                
                //                self.selsectedHotelId = getHotelIdArr[indexPath.row]
                //
                //                print(selsectedHotelId)
                //                hotelVC.hotelId = selsectedHotelId
                self.navigationController?.pushViewController(activityVC, animated: true)
            }
        }
        
        if collectionView == chooseCityAdvCollectionView {

            if indexPath.row == 0 {

                cityAdvenImagesArray = cityImagesArr
                cityAdvenCollectionView.reloadData()

            } else if indexPath.row == 1 {

                cityAdvenImagesArray = ActiviyImagesArr
                cityAdvenCollectionView.reloadData()
            }
        }
        }
    
}
