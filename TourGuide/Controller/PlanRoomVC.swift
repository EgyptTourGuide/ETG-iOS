//
//  PlanRoomVC.swift
//  TourGuide
//
//  Created by samaa on 12/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class PlanRoomVC: UIViewController {

    //MARK: -Outlets
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
    
    //MARK: -Variables
    var rooms = [Dictionary<String,Any>]()
    var roomPriceArr = [Int]()
    var roomStatusArr = [String]()
    var roommediaArr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        // Do any additional setup after loading the view.
    }
    
    //MARK: -Helper functions
    func getData() {
        
        for room in rooms {
            
            self.roomPriceArr.append(room["price"] as! Int)
            let rmedia = room["media"] as! [String]
            self.roommediaArr.append(rmedia[0])
            self.roomStatusArr.append(room["status"] as! String)
        }
    }
    
}


extension PlanRoomVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return roommediaArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = roomCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomPlanCVCell", for: indexPath) as! RoomPlanCVCell
        
        cell.roomImageView.image = getImage(from: roommediaArr[indexPath.row])
        cell.roomPriceLabel.text = "\(roomPriceArr[indexPath.row]) EGP"
        cell.roomStatusLabel.text = roomStatusArr[indexPath.row]
        
        return cell
    }
    
    
}
