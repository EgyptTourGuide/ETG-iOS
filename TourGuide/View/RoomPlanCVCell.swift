//
//  RoomPlanCVCell.swift
//  TourGuide
//
//  Created by samaa on 12/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class RoomPlanCVCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var roomImageView: UIImageView! {
        didSet {
            roomImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var roomPriceLabel: UILabel!
    @IBOutlet weak var roomStatusLabel: UILabel!
}
