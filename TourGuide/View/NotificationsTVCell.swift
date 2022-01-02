//
//  NotificationsTVCell.swift
//  TourGuide
//
//  Created by samaa on 14/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class NotificationsTVCell: UITableViewCell {

    @IBOutlet weak var notificatiosImageView: UIImageView! {
        didSet {
            notificatiosImageView.layer.cornerRadius = notificatiosImageView.frame.width / 2
        }
    }
    @IBOutlet weak var notificationstaxtLabel: UILabel!
    @IBOutlet weak var notifTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
