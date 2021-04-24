//
//  ProgramVC.swift
//  TourGuide
//
//  Created by samaa on 27/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class ProgramVC: UIViewController {

    //MARK: -IBOutlets
    
    @IBOutlet weak var cityImagesCollectionView: UICollectionView!
    
    
    //MARK: -Variables
    let cityImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "desertSafariHome"), #imageLiteral(resourceName: "LuxorTample"), #imageLiteral(resourceName: "airBallon")]
    
    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
    }
    

    //MARK: -IBActions
    
    
    //MARK: -Helper Functions

    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Program"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}

extension ProgramVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cityImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cityImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "City_ProgramCVCell", for: indexPath) as! City_ProgramCVCell
        cell.cityImage.image = cityImagesArray[indexPath.row]
        return cell
    }
    
    
    
}
