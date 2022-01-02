//
//  NotificationsVC.swift
//  TourGuide
//
//  Created by samaa on 14/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class NotificationsVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var notificationsTableView: UITableView!
    
    //MARK: -Variables
    var getNotificationArr = [GetNotification]()
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        getNotifications()
    }
    
    
    //MARK: -API Calls
    func getNotifications() {
        
        guard let url = URL(string: "\(offlineURL)/profile/notifications") else {return}
        
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken")
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken ?? "There is no token")
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        //        print("Favorites \(alamoHeader!)")
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                
                switch response.result {
                    
                case .success(_):
                    
                    let repValue = response.value as? Dictionary<String,AnyObject>
                    //                    print("getNotification success \(repValue)")
                    let notifications = repValue!["notifications"] as? [Dictionary<String,AnyObject>]
                    //print(notifications!)
                    
                    for notification in notifications! {
                        
                        let getNotification = GetNotification(notification: notification)
                        self.getNotificationArr.append(getNotification)
                        
                    }
                    
                    self.notificationsTableView.reloadData()
                    
                case .failure(_):
                    
                    print(response.error?.localizedDescription ?? "Eroor: Failure")
                }
        }
        
    }

    //MARK: -Helper Functions
    func setUpTableView() {
        
        notificationsTableView.separatorStyle = .none
    }

}


extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getNotificationArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = notificationsTableView.dequeueReusableCell(withIdentifier: "NotificationsTVCell", for: indexPath) as! NotificationsTVCell
        
        cell.notifTitleLabel.text = getNotificationArr[indexPath.row].title
        cell.notificationstaxtLabel.text = getNotificationArr[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return SCREEN_HEIGHT / 8
    }
    
    
}
