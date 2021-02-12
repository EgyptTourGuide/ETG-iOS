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
    
    
    //MARK: -Variables
    let cityImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]
    
    
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
        
        cityImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = plansCollectionView.dequeueReusableCell(withReuseIdentifier: "PlansCVCell", for: indexPath) as! PlansCVCell
        
        cell.plansImageView.image = cityImagesArray[indexPath.row]
        
        return cell
    }
    
    
    
}
