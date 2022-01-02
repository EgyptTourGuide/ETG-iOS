//
//  ChooseProFavCVCell.swift
//  TourGuide
//
//  Created by samaa on 15/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class ChooseProFavCVCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var cellLabel: UILabel! 
    @IBOutlet weak var underLineView: UIView! {
        didSet {
            underLineView.isHidden = true
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                cellLabel.textColor = #colorLiteral(red: 0.003591888817, green: 0.6864221096, blue: 0.5671058297, alpha: 1)
                underLineView.isHidden = false
                underLineView.backgroundColor = #colorLiteral(red: 0.003591888817, green: 0.6864221096, blue: 0.5671058297, alpha: 1)
                
            } else {
                cellLabel.textColor = .white
                underLineView.isHidden = true
                underLineView.backgroundColor = .white
            }
        }
    }
}
