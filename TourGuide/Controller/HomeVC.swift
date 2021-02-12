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
            searchTF.layer.cornerRadius = 15
            searchTF.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var recomndedCollectionView: UICollectionView!
    @IBOutlet weak var cityAdvenCollectionView: UICollectionView!
    
    @IBOutlet weak var citiesBtnOutlet: UIButton!
    @IBOutlet weak var adventuresBtnOutlet: UIButton!
    
    
    //MARK: -Variables
    let recomendedImagesArray = [#imageLiteral(resourceName: "divingHomePhoto"), #imageLiteral(resourceName: "desertSafariHome"), #imageLiteral(resourceName: "divingHomePhoto"), #imageLiteral(resourceName: "desertSafariHome"), #imageLiteral(resourceName: "divingHomePhoto")]
    var cityAdvenImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]

    //MARK: -View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    //MARK: -IBActions
    @IBAction func citiesBtnPressed(_ sender: UIButton) {
        cityAdvenImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]
        
    }
    
    @IBAction func adventuresBtnPressed(_ sender: UIButton) {
        sender.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cityAdvenImagesArray = [#imageLiteral(resourceName: "airBallonAdven"), #imageLiteral(resourceName: "divingAdven"), #imageLiteral(resourceName: "desertsafariAdven"), #imageLiteral(resourceName: "spaAdven")]
    }
    
    
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
        } else {
            let cell = cityAdvenCollectionView.dequeueReusableCell(withReuseIdentifier: "CityAdvenCVCell", for: indexPath) as! CityAdvenCVCell
            cell.cityAdvenImageView.image = cityAdvenImagesArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cityAdvenCollectionView {
            let cityVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "CityVC") as! CityVC
            
//            cityVC.modalPresentationStyle = .fullScreen
//            self.present(cityVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(cityVC, animated: true)
        }
    }
}
