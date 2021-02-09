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
            hotelDetailsView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var fromTF: UITextField! {
        didSet {
            fromTF.layer.cornerRadius = 15
            fromTF.attributedPlaceholder = NSAttributedString(string: "From", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var toTF: UITextField! {
        didSet {
            toTF.layer.cornerRadius = 15
            toTF.attributedPlaceholder = NSAttributedString(string: "To", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var adultsTF: UITextField! {
        didSet {
            adultsTF.layer.cornerRadius = 15
            adultsTF.attributedPlaceholder = NSAttributedString(string: "Adults", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var childrenTF: UITextField! {
        didSet {
            childrenTF.layer.cornerRadius = 15
            childrenTF.attributedPlaceholder = NSAttributedString(string: "Children", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var roomTF: UITextField! {
        didSet {
            roomTF.layer.cornerRadius = 15
            roomTF.attributedPlaceholder = NSAttributedString(string: "Room", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var bedTF: UITextField! {
        didSet {
            bedTF.layer.cornerRadius = 15
            bedTF.attributedPlaceholder = NSAttributedString(string: "Bed", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var mealsTF: UITextField! {
        didSet {
            mealsTF.layer.cornerRadius = 15
            mealsTF.attributedPlaceholder = NSAttributedString(string: "Meals", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(1)])
        }
    }
    @IBOutlet weak var featuresTF: UITextField! {
        didSet {
            featuresTF.layer.cornerRadius = 15
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

        // Do any additional setup after loading the view.
    }
    
    //MARK: -IBActions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func skipHotelDetailsBtnPressed(_ sender: UIButton) {
        hotelDetailsView.isHidden = true
    }
    
    //MARK: -Helper functions
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
    
}
