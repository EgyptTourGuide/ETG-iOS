//
//  CityAdvenCVCell.swift
//  TourGuide
//
//  Created by samaa on 09/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class CityAdvenCVCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var cityAdvenImageView: UIImageView! {
        didSet {
            cityAdvenImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var likeBtnOutlet: UIButton!
    @IBOutlet weak var cityAdvenLabel: UILabel!
    @IBOutlet weak var locationBtnOutlet: UIButton!
}
