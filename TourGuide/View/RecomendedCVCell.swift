//
//  RecomendedCVCell.swift
//  TourGuide
//
//  Created by samaa on 08/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class RecomendedCVCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var recomndedImageView: UIImageView! {
        didSet {
            recomndedImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var likeBtnOutlet: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
}
