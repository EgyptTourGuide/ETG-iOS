//
//  RoomVC.swift
//  TourGuide
//
//  Created by samaa on 26/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class RoomVC: UIViewController {

    //MARK: -IBOutlets
    
    @IBOutlet weak var mainRoomCollectionView: UICollectionView!
    
    @IBOutlet weak var reserveBtnOutlet: UIButton! {
        didSet {
            reserveBtnOutlet.layer.cornerRadius = reserveBtnOutlet.frame.height / 2
        }
    }
    
    
    //MARK: -Variables
    let roomImagesArray = [#imageLiteral(resourceName: "room2"), #imageLiteral(resourceName: "mainRoom2"), #imageLiteral(resourceName: "mainRoom3"), #imageLiteral(resourceName: "mainRoom4")]
    var getRoomArr = [GetRooms]()
    
    
    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        print(getRoomArr)
    }
    

    //MARK: - Helper Functions
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Room"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}


extension RoomVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        roomImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = mainRoomCollectionView.dequeueReusableCell(withReuseIdentifier: "MainRoomCVCell", for: indexPath) as! MainRoomCVCell
        cell.mainRoomImageView.image = roomImagesArray[indexPath.row]
        
        return cell
    }
    
    
    
}
