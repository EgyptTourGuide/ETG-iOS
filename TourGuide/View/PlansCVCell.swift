//
//  PlansCVCell.swift
//  TourGuide
//
//  Created by samaa on 12/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class PlansCVCell: UICollectionViewCell {
    
    @IBOutlet weak var planscellView: UIView! {
        didSet {
            planscellView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var plansImageView: UIImageView! {
        didSet {
            plansImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var goBtnOutlet: UIButton! {
        didSet {
            goBtnOutlet.layer.cornerRadius = goBtnOutlet.frame.height / 2
        }
    }
}
