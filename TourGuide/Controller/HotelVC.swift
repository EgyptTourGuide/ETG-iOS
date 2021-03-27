//
//  HotelVC.swift
//  TourGuide
//
//  Created by samaa on 01/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class HotelVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewsTableView: UITableView! {
        didSet {
            reviewsTableView.layer.borderWidth = 2
            reviewsTableView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            reviewsTableView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var addCommentView: UIView! {
        didSet {
            addCommentView.isHidden = true
            addCommentView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var addReviewBtnOutlet: UIButton! {
        didSet {
            addReviewBtnOutlet.layer.cornerRadius = addReviewBtnOutlet.frame.height / 2
        }
    }
    
    //MARK: -Variables
    let roomImagesArray = [#imageLiteral(resourceName: "room2"), #imageLiteral(resourceName: "room3"), #imageLiteral(resourceName: "room1"), #imageLiteral(resourceName: "room2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
    }
    

    //MARK: -IBActions
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        
        addCommentView.isHidden = false
    }
    
    @IBAction func addCommentBtnPRessed(_ sender: Any) {
        addCommentView.isHidden = true
    }
    
    
    //MARK:- Helper Functions
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Hotel"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

extension HotelVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return roomImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = roomCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomCVCell", for: indexPath) as! RoomCVCell
        cell.roomImgeView.image = roomImagesArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let roomVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "RoomVC") as! RoomVC
        
        self.navigationController?.pushViewController(roomVC, animated: true)
    }
}


extension HotelVC: UITableViewDataSource, UITableViewDelegate {
    
    
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
