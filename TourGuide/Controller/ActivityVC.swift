//
//  ActivityVC.swift
//  TourGuide
//
//  Created by samaa on 26/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class ActivityVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var whereToDoCollectionView: UICollectionView!
    @IBOutlet weak var reviewsTableView: UITableView!
    
  
    
    @IBOutlet weak var addReviewBtnOutlet: UIButton! {
        didSet {
            addReviewBtnOutlet.layer.cornerRadius = addReviewBtnOutlet.frame.height / 2
        }
    }
    //MARK: -Variables
    var whereToDoImagesArray = [#imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex"), #imageLiteral(resourceName: "luxor"), #imageLiteral(resourceName: "Cairo"), #imageLiteral(resourceName: "Aswan"), #imageLiteral(resourceName: "Alex")]
    
    
    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
    }
    

    //MARK: -IBActions
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        
    }
    
    
    //MARK: -Helper Functions
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Activity"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}


extension ActivityVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reviewsTableView.dequeueReusableCell(withIdentifier: "CommentsTVCell", for: indexPath) as! CommentsTVCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return reviewsTableView.frame.height
    }
    
}


extension ActivityVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return whereToDoImagesArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = whereToDoCollectionView.dequeueReusableCell(withReuseIdentifier: "CityPlacesCVCell", for: indexPath) as! CityPlacesCVCell
        cell.placHDImageView.image = whereToDoImagesArray[indexPath.row]
        return cell
        
    }
    
}
