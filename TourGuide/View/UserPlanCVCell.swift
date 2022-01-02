//
//  UserPlanCVCell.swift
//  TourGuide
//
//  Created by samaa on 12/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class UserPlanCVCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var planImageView: UIImageView! {
        didSet {
            planImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var planPriceLabel: UILabel!
    @IBOutlet weak var planPersonsLabel: UILabel!
    
}
