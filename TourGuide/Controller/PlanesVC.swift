//
//  PlanesVC.swift
//  TourGuide
//
//  Created by samaa on 12/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class PlanesVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var plansCollectionView: UICollectionView!
    @IBOutlet weak var chooseCollectionView: UICollectionView!
    
    
    //MARK: -Variables
    var progFavImagesArray = [String]()
    let labelsArray = ["Programs city", "Favorite"]
    var getFavoriteArr = [GetFavorites]()
    var getCityArr = [GetCity]()
    var favoritesImagesArr = [String]()
    var cityImagesArr = [String]()

    var type = ""
    var selectedId = ""
    var selectedCityId = ""
    
    
    //MARK: -View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_cities()
        getFavorites()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getFavorites()
    }
    
    //MARK: -IBActions
    
    //MARK: -API Calls
    func getFavorites() {
        
        guard let url = URL(string: "\(offlineURL)/profile/favourites") else {return}
        
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        //print("Favorites \(alamoHeader!)")
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                switch response.result {
                    
                case .success(_):
                    
                    let repValue = response.value as AnyObject
                    //print("Favorites success \(repValue)")
                    let favourites = repValue["favourites"] as? [Dictionary<String,Any>]
                    //print(favourites!)
                    
                    for favorite in favourites! {
                        //print(favorite)
                        let getFavourite = GetFavorites(favorite: favorite)
                        //print(getFavourite)
                        self.getFavoriteArr.append(getFavourite)
                        self.favoritesImagesArr.append(getFavourite.media![0])
                        //print(self.getFavoriteArr)
                    }
                    
                    self.plansCollectionView.reloadData()
                case .failure(_):
                    
                    print(response.error?.localizedDescription ?? "Eroor: Failure")
                }
        }
        
    }
    
    func get_cities() {
        
        guard let url = URL(string: "\(offlineURL)/cities/plan/all") else {return}
        
        let header = Constants().defaultHeader
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
                
                self.plansCollectionView.reloadData()

            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Error")
            }
        }
    }
    
    
    //MARK: -Helper Functions
    
    
}


extension PlanesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == chooseCollectionView {
            return labelsArray.count
        } else {
            return progFavImagesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == chooseCollectionView {
            
            let cell = chooseCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseProFavCVCell", for: indexPath) as! ChooseProFavCVCell
            
            cell.cellLabel.text = labelsArray[indexPath.row]
            
            return cell
        } else {
            
            let cell = plansCollectionView.dequeueReusableCell(withReuseIdentifier: "PlansCVCell", for: indexPath) as! PlansCVCell
            
            if progFavImagesArray == favoritesImagesArr {
                
                cell.plansImageView.image = getImage(from: progFavImagesArray[indexPath.row])
                cell.cityNameLabel.text = getFavoriteArr[indexPath.row].name
                
            } else if progFavImagesArray == cityImagesArr {
                
                cell.plansImageView.image = getImage(from: progFavImagesArray[indexPath.row])
                cell.cityNameLabel.text = getCityArr[indexPath.row].name
            }
            
            return cell
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == plansCollectionView {
            
            if progFavImagesArray == favoritesImagesArr {
                
                if let type = getFavoriteArr[indexPath.row].type, type == "place", let placeId = getFavoriteArr[indexPath.row].id  {
                    
                    self.selectedId = placeId
                    //print("selected \(selectedPlaceId)")
                    
                    let placeDetailsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "PlaceDetailsVC") as! PlaceDetailsVC
                    
                    //print(selectedPlaceId)
                    placeDetailsVC.placeId = selectedId
                    self.navigationController?.pushViewController(placeDetailsVC, animated: true)
                }
                
            } else if progFavImagesArray == cityImagesArr {
                
                let allPlansVC = UIStoryboard(name: "AddNewPlane", bundle: nil).instantiateViewController(identifier: "AllPlansVC") as! AllPlansVC
                
                if let cityId = getCityArr[indexPath.row].id {
                    
                    self.selectedCityId = cityId
                    //print("selected \(selectedCityId)")
                }
                
                //print(selectedCityId)
                allPlansVC.cityId = selectedCityId
                
                self.navigationController?.pushViewController(allPlansVC, animated: true)
                
            }
            
        }
        
        if collectionView == chooseCollectionView {
            
            if indexPath.row == 1 {
                
                progFavImagesArray = favoritesImagesArr
                plansCollectionView.reloadData()
            } else {
                progFavImagesArray = cityImagesArr
                plansCollectionView.reloadData()
            }
        }
        
        
    }
    
}
