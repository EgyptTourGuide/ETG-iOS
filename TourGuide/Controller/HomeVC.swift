//
//  HomeVC.swift
//  TourGuide
//
//  Created by samaa on 08/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

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
    var cityAdvenImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]
    let labelsArray = ["Cities", "Adventures"]
    
    
    
    //MARK: -View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    //MARK: -IBActions
    
    
    //MARK: -Helper functions

}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recomndedCollectionView {
            return recomendedImagesArray.count
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
            cell.cityAdvenImageView.image = cityAdvenImagesArray[indexPath.row]
            return cell
            
        } else {
            let cell1 = chooseCityAdvCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseProFavCVCell", for: indexPath) as! ChooseProFavCVCell
            
            cell1.cellLabel.text = labelsArray[indexPath.row]
            return cell1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cityAdvenCollectionView {
            
            let cityVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "CityVC") as! CityVC
          
            self.navigationController?.pushViewController(cityVC, animated: true)
        }
        if collectionView == chooseCityAdvCollectionView {
            
            if indexPath.row == 0 {
                
                cityAdvenImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]
                cityAdvenCollectionView.reloadData()
            } else if indexPath.row == 1 {
                
                cityAdvenImagesArray = [#imageLiteral(resourceName: "divingAdven"), #imageLiteral(resourceName: "desertsafariAdven"), #imageLiteral(resourceName: "airBallonAdven"), #imageLiteral(resourceName: "spaAdven"), #imageLiteral(resourceName: "divingAdven"), #imageLiteral(resourceName: "desertsafariAdven"), #imageLiteral(resourceName: "airBallonAdven"), #imageLiteral(resourceName: "spaAdven")]
                cityAdvenCollectionView.reloadData()
            }
        }
        }
    
}
