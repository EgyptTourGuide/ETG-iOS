//
//  CityVC.swift
//  TourGuide
//
//  Created by samaa on 09/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class CityVC: UIViewController {

    //MARK: -IBOutlets
    
    @IBOutlet weak var hotelDetailsView: UIView! {
        didSet {
            hotelDetailsView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var fromTF: UITextField! {
        didSet {
            fromTF.layer.cornerRadius = fromTF.frame.height / 2
            fromTF.attributedPlaceholder = NSAttributedString(string: "From", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var toTF: UITextField! {
        didSet {
            toTF.layer.cornerRadius = toTF.frame.height / 2
            toTF.attributedPlaceholder = NSAttributedString(string: "To", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var adultsTF: UITextField! {
        didSet {
            adultsTF.layer.cornerRadius = adultsTF.frame.height / 2
            adultsTF.attributedPlaceholder = NSAttributedString(string: "Adults", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var childrenTF: UITextField! {
        didSet {
            childrenTF.layer.cornerRadius = childrenTF.frame.height / 2
            childrenTF.attributedPlaceholder = NSAttributedString(string: "Children", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var roomTF: UITextField! {
        didSet {
            roomTF.layer.cornerRadius = roomTF.frame.height / 2
            roomTF.attributedPlaceholder = NSAttributedString(string: "Room", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var bedTF: UITextField! {
        didSet {
            bedTF.layer.cornerRadius = bedTF.frame.height / 2
            bedTF.attributedPlaceholder = NSAttributedString(string: "Bed", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var mealsTF: UITextField! {
        didSet {
            mealsTF.layer.cornerRadius = mealsTF.frame.height / 2
            mealsTF.attributedPlaceholder = NSAttributedString(string: "Meals", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var featuresTF: UITextField! {
        didSet {
            featuresTF.layer.cornerRadius = featuresTF.frame.height / 2
            featuresTF.attributedPlaceholder = NSAttributedString(string: "Features", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    
    @IBOutlet weak var goBtnOutlet: UIButton! {
        didSet {
            goBtnOutlet.layer.cornerRadius = goBtnOutlet.frame.height / 2
        }
    }
    
    @IBOutlet weak var searchTF: UITextField! {
        didSet {
            searchTF.layer.cornerRadius = 15
            searchTF.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var backBtnOutlet: UIButton!
    @IBOutlet weak var citiesHDCollectionView: UICollectionView!
    @IBOutlet weak var chooseCollectionView: UICollectionView!
    
    @IBOutlet weak var backgroundConnectionView: UIView! {
        didSet {
            backgroundConnectionView.layer.cornerRadius = 20
        }
    }
    
    
    //MARK: -Variables
    var PlaHoDelImagesArray = [String]()
    let labelsArray = ["Places", "Hotels","Delights"]
    var cityId = ""
    var getPlaceArr = [GetPlace]()
    var placeImagesArr = [String]()
    var selectedPlaceId = ""
    
    //MARK: -View functions
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpNavBar()
        get_places()
        self.citiesHDCollectionView.reloadData()
    }
    
    //MARK: -IBActions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func skipHotelDetailsBtnPressed(_ sender: UIButton) {
        
        hotelDetailsView.isHidden = true
    }
    
    //MARK: -Helper functions
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "City"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func get_places() {
        
        guard let url = URL(string: "https://egypttourguide.herokuapp.com/places?city=\(cityId)") else {return}
        
        print(url)
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
                    //print(self.placeImagesArr)
                }
                
                self.citiesHDCollectionView.reloadData()
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Eroor: Failure")
            }
        }
    }

    
}


extension CityVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == chooseCollectionView {
            
            return labelsArray.count
        } else {
            
            return placeImagesArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == citiesHDCollectionView  {
            
            let cell = citiesHDCollectionView.dequeueReusableCell(withReuseIdentifier: "CityPlacesCVCell", for: indexPath) as! CityPlacesCVCell
            
            cell.placeHDNameLabel.text = getPlaceArr[indexPath.row].name
            cell.placHDImageView.image = getImage(from: placeImagesArr[indexPath.row])
            
            return cell
            
        } else {
            
            let cell = chooseCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseProFavCVCell", for: indexPath) as! ChooseProFavCVCell
            cell.cellLabel.text = labelsArray[indexPath.row]
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == citiesHDCollectionView  {
            
            let placeDetailsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "PlaceDetailsVC") as! PlaceDetailsVC

            if let placeId = getPlaceArr[indexPath.row].id {
                
                self.selectedPlaceId = placeId
                print("selected \(selectedPlaceId)")
            }
            
            print(selectedPlaceId)
            placeDetailsVC.placeId = selectedPlaceId
            self.navigationController?.pushViewController(placeDetailsVC, animated: true)
                
        }
        
    }
    
}
