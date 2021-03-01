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
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
    
    //MARK: -Variables
    let roomImagesArray = [#imageLiteral(resourceName: "room2"), #imageLiteral(resourceName: "room3"), #imageLiteral(resourceName: "room1"), #imageLiteral(resourceName: "room2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    
}
