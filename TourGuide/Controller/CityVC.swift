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
    var getActivityArr = [GetActivity]()
    var placeImagesArr = [String]()
    var getHotelIdArr = [String]()
    var getHotelNamesArr = [String]()
    var hotelImagesArr = [String]()
    var selectedPlaceId = ""
    var selsectedHotelId = ""
    var selsectedActivityId = ""
    var selectedActivityName = ""
    var getActiviyIdArr = [String]()
    var getActiviyNamesArr = [String]()
    var ActiviyImagesArr = [String]()
    var bed: Int?
    var features = [String]()
//    var datePicker: UIDatePicker?
    
    //MARK: -View functions
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpNavBar()
        get_places()
        get_hotels()
        get_activities()
//        setUpFromDatePicker()
//        setUpToDatePicker()
    }
    
    //MARK: -IBActions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func skipHotelDetailsBtnPressed(_ sender: UIButton) {
        
        hotelDetailsView.isHidden = true
    }
    
//    @objc func fromTFdatePicked(datePicker: UIDatePicker) {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        fromTF.text = dateFormatter.string(from: datePicker.date)
//        //view.endEditing(true)
//    }
//
//    @objc func toTFdatePicked(datePicker: UIDatePicker) {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        toTF.text = dateFormatter.string(from: datePicker.date)
//        //view.endEditing(true)
//    }
//
//    @objc func endPicking(tapGestureRecognizer: UITapGestureRecognizer) {
//
//        view.endEditing(true)
//    }
    
    @IBAction func filterBtnPressed(_ sender: UIButton) {
        
        //get_filteredhotels()
    }
    
    //MARK: - API Calls
    
    func get_places() {
        
        guard let url = URL(string: "\(offlineURL)/places?city=\(cityId)") else {return}
        
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
                    //print(self.placeImagesArr)
                }
                
                self.citiesHDCollectionView.reloadData()
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Eroor: Failure")
            }
        }
    }
    
//    func get_filteredhotels() {
//        
//        get_filteredhotels()
//        guard let url = URL(string: "\(onlineURL)/hotels?city=\(cityId)&from=\(String(describing: fromTF.text))&to=\(String(describing: toTF.text))") else {return}
//        
//        //print(url)
//        let header = ["Content-Type":"application/json; charset=utf-8"]
//        let alamoHeader = HTTPHeaders(header)
//        
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in
//            
//            switch response.result {
//                
//            case .success(_):
//                
//                let repValue = response.value as! [AnyObject]
//                
//                for hotel in repValue {
//                    
//                    let getHotel = GetHotels(hotels: hotel as! Dictionary<String, Any>)
//                    self.getHotelIdArr.append(getHotel.id!)
//                    self.getHotelNamesArr.append(getHotel.name!)
//                    //                    print("Ids: \(self.getHotelIdArr)")
//                    //                    print("Names: \(self.getHotelNamesArr)")
//                    self.hotelImagesArr.append(getHotel.media![0])
//                    //print(self.hotelImagesArr)
//                    //print(self.placeImagesArr)
//                }
//                
//                self.citiesHDCollectionView.reloadData()
//                
//            case .failure(_):
//                
//                print(response.error?.localizedDescription ?? "Eroor: Failure")
//                print(response.debugDescription)
//            }
//        }
//    }

    func get_hotels() {
        
        guard let url = URL(string: "\(offlineURL)/hotels?city=\(cityId)") else {return}
        
        //print(url)
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                
                let repValue = response.value as! [AnyObject]

                for hotel in repValue {

                    let getHotel = GetHotels(hotels: hotel as! Dictionary<String, Any>)
                    self.getHotelIdArr.append(getHotel.id!)
                    self.getHotelNamesArr.append(getHotel.name!)
//                    print("Ids: \(self.getHotelIdArr)")
//                    print("Names: \(self.getHotelNamesArr)")
                    self.hotelImagesArr.append(getHotel.media![0])
                    //print(self.hotelImagesArr)
                    //print(self.placeImagesArr)
                }
                
                self.citiesHDCollectionView.reloadData()
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Eroor: Failure")
                print(response.debugDescription)
            }
        }
    }
    
    func get_activities() {
        
        guard let url = URL(string: "\(offlineURL)/activity?city=\(cityId)") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)
        print("Activities \(alamoHeader)")
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                
                let repValue = response.value as? Dictionary<String,AnyObject>
                let activities = repValue!["activities"] as? [Dictionary<String,AnyObject>]
                //print(repValue)
                
                for activity in activities! {
                    
                    let getActivity = GetActivity(activity: activity)
                    self.getActivityArr.append(getActivity)
                    self.ActiviyImagesArr.append(getActivity.media![0])
                    
                }
                                
                self.citiesHDCollectionView.reloadData()
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Error")
            }
        }
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
    
//    func setUpFromDatePicker() {
//
//        datePicker = UIDatePicker()
//        datePicker?.datePickerMode = .date
//        datePicker?.addTarget(self, action: #selector(fromTFdatePicked(datePicker:)), for: .valueChanged)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endPicking(tapGestureRecognizer:)))
//
//        view.addGestureRecognizer(tapGesture)
//        fromTF.inputView = datePicker
//    }
    
//    func setUpToDatePicker() {
//
//        datePicker = UIDatePicker()
//        datePicker?.datePickerMode = .date
//        datePicker?.addTarget(self, action: #selector(toTFdatePicked(datePicker:)), for: .valueChanged)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endPicking(tapGestureRecognizer:)))
//
//        view.addGestureRecognizer(tapGesture)
//        toTF.inputView = datePicker
//    }
    
    func geFilterData() {
        
        if !bedTF.text!.isEmpty {
            bed = Int(bedTF.text!)
        }
        
        if !featuresTF.text!.isEmpty {
            features.append(featuresTF.text!)
        }
        
    }
    
}


extension CityVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == chooseCollectionView {
            
            return labelsArray.count
        } else {
            
            return PlaHoDelImagesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == citiesHDCollectionView  {
            
            let cell = citiesHDCollectionView.dequeueReusableCell(withReuseIdentifier: "CityPlacesCVCell", for: indexPath) as! CityPlacesCVCell
            
            if PlaHoDelImagesArray == placeImagesArr {
                
                cell.placeHDNameLabel.text = getPlaceArr[indexPath.row].name
                cell.placHDImageView.image = getImage(from: placeImagesArr[indexPath.row])
                
            } else if PlaHoDelImagesArray == hotelImagesArr {
                
                cell.placeHDNameLabel.text = getHotelNamesArr[indexPath.row]
                cell.placHDImageView.image = getImage(from: hotelImagesArr[indexPath.row])
                
            } else if PlaHoDelImagesArray == ActiviyImagesArr {
                
                cell.placeHDNameLabel.text = getActivityArr[indexPath.row].name
                cell.placHDImageView.image = getImage(from: ActiviyImagesArr[indexPath.row])
            }
            
            return cell
            
        } else {
            
            let cell = chooseCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseProFavCVCell", for: indexPath) as! ChooseProFavCVCell
            cell.cellLabel.text = labelsArray[indexPath.row]
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == citiesHDCollectionView  {
            
            if PlaHoDelImagesArray == placeImagesArr {
                
                let placeDetailsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "PlaceDetailsVC") as! PlaceDetailsVC
                
                if let placeId = getPlaceArr[indexPath.row].id {
                    
                    self.selectedPlaceId = placeId
                    //print("selected \(selectedPlaceId)")
                }
                
                //print(selectedPlaceId)
                placeDetailsVC.placeId = selectedPlaceId
                self.navigationController?.pushViewController(placeDetailsVC, animated: true)
                
            } else if PlaHoDelImagesArray == hotelImagesArr {
                
                let hotelVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HotelVC") as! HotelVC
                
                self.selsectedHotelId = getHotelIdArr[indexPath.row] 
                
                //print(selsectedHotelId)
                hotelVC.hotelId = selsectedHotelId
                self.navigationController?.pushViewController(hotelVC, animated: true)
                
            } else if PlaHoDelImagesArray == ActiviyImagesArr {
                
                let activityVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "ActivityVC") as! ActivityVC
                
                if let activityId = getActivityArr[indexPath.row].id {
                    
                    self.selsectedActivityId = activityId
                    //print("selected \(selsectedActivityId)")
                }
                if let activtyName = getActivityArr[indexPath.row].name {
                    
                    self.selectedActivityName = activtyName
                    //print("selected \(selectedActivityName)")
                }
                
                activityVC.activityId = selsectedActivityId
                activityVC.activityName = selectedActivityName
                self.navigationController?.pushViewController(activityVC, animated: true)
            }
        }
        
        
        if collectionView == chooseCollectionView {
            
            if indexPath.row == 0 {
                
                PlaHoDelImagesArray = placeImagesArr
                citiesHDCollectionView.reloadData()
                
            } else if indexPath.row == 1 {
                
                PlaHoDelImagesArray = hotelImagesArr
                citiesHDCollectionView.reloadData()
                
            } else if indexPath.row == 2 {
                
                PlaHoDelImagesArray = ActiviyImagesArr
                citiesHDCollectionView.reloadData()
            }
        }
    }
    
}
