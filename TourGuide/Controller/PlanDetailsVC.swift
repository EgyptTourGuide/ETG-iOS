//
//  PlanDetailsVC.swift
//  TourGuide
//
//  Created by samaa on 12/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class PlanDetailsVC: UIViewController {

    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var transportImageView: UIImageView!
    @IBOutlet weak var transportTypeLabel: UILabel!
    @IBOutlet weak var transportSeatsLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var driverPhoneLabel: UILabel!
    @IBOutlet weak var personsNumLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    //MARK: -Variables
    var plan: Dictionary<String,Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
//        print(plan)
        // Do any additional setup after loading the view.
    }
    
    //MARK: -Helper functions
    func getData() {
        
        if let plan = plan {
            let p = plan["plan"] as! Dictionary<String,Any>
            self.planNameLabel.text = (p["title"] as! String)
            self.personsNumLabel.text = (plan["persons"] as! String)
            self.totalPriceLabel.text = (plan["price"] as! String)
            self.startDateLabel.text = (plan["startDate"] as! String)
            let transport = plan["transport"] as! Dictionary<String,Any>
            self.driverNameLabel.text = (transport["driver"] as! String)
            self.driverPhoneLabel.text = (transport["phone"] as! String)
            //self.transportSeatsLabel.text = ("\(transport["seats"] as! String)")
            let transmedia = (transport["media"] as! [String])
            self.transportImageView.image = getImage(from: transmedia[0])
        }
    }

}
