//
//  UserHotelCVCell.swift
//  TourGuide
//
//  Created by samaa on 12/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class UserHotelCVCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var hotelImageView: UIImageView!  {
           didSet {
               hotelImageView.layer.cornerRadius = 10
           }
       }
    @IBOutlet weak var hotelNameLabel: UILabel!
}
