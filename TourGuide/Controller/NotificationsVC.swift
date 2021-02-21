//
//  NotificationsVC.swift
//  TourGuide
//
//  Created by samaa on 14/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {

    @IBOutlet weak var notificationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationsTableView.separatorStyle = .none
    }
    

}


extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = notificationsTableView.dequeueReusableCell(withIdentifier: "NotificationsTVCell", for: indexPath) as! NotificationsTVCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return SCREEN_HEIGHT / 8
    }
    
    
}
