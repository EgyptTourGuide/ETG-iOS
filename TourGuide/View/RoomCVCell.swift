//
//  RoomCVCell.swift
//  TourGuide
//
//  Created by samaa on 01/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class RoomCVCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var roomImgeView: UIImageView!
    @IBOutlet weak var reserveBtnOutlet: UIButton! {
        didSet {
            reserveBtnOutlet.layer.cornerRadius = reserveBtnOutlet.frame.height / 2
        }
    }
    
    @IBOutlet weak var numOfBedsLabel: UILabel!
    @IBOutlet weak var nimOfMealsLabel: UILabel!
}
