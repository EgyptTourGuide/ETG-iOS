//
//  PlanesVC.swift
//  TourGuide
//
//  Created by samaa on 12/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class PlanesVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var plansCollectionView: UICollectionView!
    @IBOutlet weak var chooseCollectionView: UICollectionView!
    
    
    //MARK: -Variables
    var progFavImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]
    let labelsArray = ["Programs", "Favorite"]
    
    //MARK: -View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: -IBActions
    
    
    
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
            
            let cell1 = chooseCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseProFavCVCell", for: indexPath) as! ChooseProFavCVCell
            
            cell1.cellLabel.text = labelsArray[indexPath.row]
            
            return cell1
        } else {
            let cell2 = plansCollectionView.dequeueReusableCell(withReuseIdentifier: "PlansCVCell", for: indexPath) as! PlansCVCell
            
            cell2.plansImageView.image = progFavImagesArray[indexPath.row]
            
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == chooseCollectionView && indexPath.row == 1 {
            progFavImagesArray = [#imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "airBallonAdven"), #imageLiteral(resourceName: "divingAdven"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "desertsafariAdven"), #imageLiteral(resourceName: "spaAdven"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]
            plansCollectionView.reloadData()
        } else {
            progFavImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]
            plansCollectionView.reloadData()
        }
    }
    
}
