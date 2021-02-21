//
//  ProfileVC.swift
//  TourGuide
//
//  Created by samaa on 21/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: -IBOutlets
    
    
    //MARK: -Variables
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    //MARK: -IBActions

    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        
        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LogInVC") as! LogInVC
        
        logInVC.modalPresentationStyle = .fullScreen
        present(logInVC, animated: true, completion: nil)
    }
    
    @IBAction func editProfileBtnPressed(_ sender: UIButton) {
        
        let editProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "EditProfileVC") as! EditProfileVC
        
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    
    //MARK: -Helper Functions

    func setUpNavBar(){

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = " "
        backButton.image = #imageLiteral(resourceName: "backBtnIcon")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
