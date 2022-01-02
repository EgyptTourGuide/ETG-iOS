//
//  AllPlansCVCell.swift
//  TourGuide
//
//  Created by samaa on 09/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class AllPlansCVCell: UICollectionViewCell {
    
    @IBOutlet weak var planName: UILabel!
    @IBOutlet weak var egyPriceLabel: UILabel!
    @IBOutlet weak var foriegnPriceLabel: UILabel!
    @IBOutlet weak var Duration_hoursLabel: UILabel!
    @IBOutlet weak var tourImageView: UIImageView! {
        didSet {
            tourImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
        }
    }
    
}
