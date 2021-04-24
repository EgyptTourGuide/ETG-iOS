//
//  CityPlacesCVCell.swift
//  TourGuide
//
//  Created by samaa on 09/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class CityPlacesCVCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var placHDImageView: UIImageView! {
        didSet {
            placHDImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var placeHDNameLabel: UILabel!
    
}
