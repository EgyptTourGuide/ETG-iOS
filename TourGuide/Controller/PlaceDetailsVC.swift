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
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var mapImageBackView: UIView! {
        didSet {
            mapImageBackView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var commentsTableView: UITableView! {
        didSet {
            commentsTableView.layer.borderWidth = 2
            commentsTableView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            commentsTableView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var addCommentView: UIView! {
        didSet {
            addCommentView.isHidden = true
            addCommentView.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
    }
    


    //MARK: -IBActions
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        
        addCommentView.isHidden = false
    }
    
    @IBAction func addCommentBtnPRessed(_ sender: Any) {
        addCommentView.isHidden = true
    }
    
    
    //MARK: -Helper Functions
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


extension PlaceDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "CommentsTVCell", for: indexPath) as! CommentsTVCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return commentsTableView.frame.height
    }
    
}
