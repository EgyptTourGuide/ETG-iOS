//
//  AddNewProgramVC.swift
//  TourGuide
//
//  Created by samaa on 14/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class AddNewProgramVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var destenationView: UIView! {
        didSet {
            destenationView.layer.cornerRadius = destenationView.frame.height / 2
        }
    }
    
    @IBOutlet weak var destenatioTF: UITextField! {
        didSet {
            destenatioTF.layer.cornerRadius = destenatioTF.frame.height / 2
            destenatioTF.attributedPlaceholder = NSAttributedString(string: "Destenation", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var fromTF: UITextField! {
        didSet {
            fromTF.layer.cornerRadius = fromTF.frame.height / 2
            fromTF.attributedPlaceholder = NSAttributedString(string: "From", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var toTF: UITextField! {
        didSet {
            toTF.layer.cornerRadius = toTF.frame.height / 2
            toTF.attributedPlaceholder = NSAttributedString(string: "To", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var adultsTF: UITextField! {
        didSet {
            adultsTF.layer.cornerRadius = adultsTF.frame.height / 2
            adultsTF.attributedPlaceholder = NSAttributedString(string: "Adults", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var childrenTF: UITextField! {
        didSet {
            childrenTF.layer.cornerRadius = childrenTF.frame.height / 2
            childrenTF.attributedPlaceholder = NSAttributedString(string: "Children", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var roomTF: UITextField! {
        didSet {
            roomTF.layer.cornerRadius = roomTF.frame.height / 2
            roomTF.attributedPlaceholder = NSAttributedString(string: "Room", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var bedTF: UITextField! {
        didSet {
            bedTF.layer.cornerRadius = bedTF.frame.height / 2
            bedTF.attributedPlaceholder = NSAttributedString(string: "Bed", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var mealsTF: UITextField! {
        didSet {
            mealsTF.layer.cornerRadius = mealsTF.frame.height / 2
            mealsTF.attributedPlaceholder = NSAttributedString(string: "Meals", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var featuresTF: UITextField! {
        didSet {
            featuresTF.layer.cornerRadius = featuresTF.frame.height / 2
            featuresTF.attributedPlaceholder = NSAttributedString(string: "Features", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var airportTF: UITextField! {
        didSet {
            airportTF.layer.cornerRadius = airportTF.frame.height / 2
            airportTF.attributedPlaceholder = NSAttributedString(string: "Airport", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    @IBOutlet weak var budgetTF: UITextField! {
        didSet {
            budgetTF.layer.cornerRadius = budgetTF.frame.height / 2
            budgetTF.attributedPlaceholder = NSAttributedString(string: "Budget", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    
    @IBOutlet weak var goBtnOutlet: UIButton! {
        didSet {
            goBtnOutlet.layer.cornerRadius = goBtnOutlet.frame.height / 2
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: -IBActions
    
    @IBAction func addNewProgBtnPressed(_ sender: UIButton) {
        
        let programVC = UIStoryboard(name: "AddNewPlane", bundle: nil).instantiateViewController(identifier: "ProgramVC") as! ProgramVC
        
          self.navigationController?.pushViewController(programVC, animated: true)
        
    }
}
