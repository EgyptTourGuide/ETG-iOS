//
//  CityVC.swift
//  TourGuide
//
//  Created by samaa on 09/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var backgroundConnectionView: UIView! {
        didSet {
            backgroundConnectionView.layer.cornerRadius = 20
        }
    }
    
    //MARK: -Variables
    let PlaHoDelImagesArray = [#imageLiteral(resourceName: "desertsafariAdven"), #imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "airBallonAdven"), #imageLiteral(resourceName: "spaAdven")]
    
    
    //MARK: -View functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
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
    
    
}


extension CityVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
            return PlaHoDelImagesArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = citiesHDCollectionView.dequeueReusableCell(withReuseIdentifier: "CityPlacesCVCell", for: indexPath) as! CityPlacesCVCell
            cell.placHDImageView.image = PlaHoDelImagesArray[indexPath.row]
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let placeDetailsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "PlaceDetailsVC") as! PlaceDetailsVC
        
        //            cityVC.modalPresentationStyle = .fullScreen
        //            self.present(cityVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(placeDetailsVC, animated: true)
        
    }
    
}
