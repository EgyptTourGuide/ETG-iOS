//
//  PlaceDetailsVC.swift
//  TourGuide
//
//  Created by samaa on 11/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class PlaceDetailsVC: UIViewController {

    //MARK: -IBOutlets
    
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = searchView.frame.height / 2
        }
    }
    
    @IBOutlet weak var searchTf: UITextField! {
        didSet {
            searchTf.layer.cornerRadius = searchTf.frame.height / 2
            searchTf.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
    }
    
    @IBOutlet weak var addReviewBtnOutlet: UIButton! {
        didSet {
            addReviewBtnOutlet.layer.cornerRadius = addReviewBtnOutlet.frame.height / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
    }
    

    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Place Details"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }


}
