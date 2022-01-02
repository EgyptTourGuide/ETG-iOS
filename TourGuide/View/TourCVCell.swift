//
//  TourCVCell.swift
//  TourGuide
//
//  Created by samaa on 10/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class TourCVCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var tourImageView: UIImageView! {
        didSet {
            tourImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
}
