//
//  RoomVC.swift
//  TourGuide
//
//  Created by samaa on 26/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RoomVC: UIViewController {

    //MARK: -IBOutlets
    
    @IBOutlet weak var mainRoomCollectionView: UICollectionView!
    
    @IBOutlet weak var reserveBtnOutlet: UIButton! {
        didSet {
            reserveBtnOutlet.layer.cornerRadius = reserveBtnOutlet.frame.height / 2
        }
    }
    
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var adultsLabel: UILabel!
    @IBOutlet weak var childsLabel: UILabel!
    @IBOutlet weak var mealsLabel: UILabel!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var roomNumLabel: UILabel!
    @IBOutlet weak var roomPriceLabel: UILabel!
    
    var datePicker: UIDatePicker?
    
    //MARK: -Variables
    var roomImagesArray = [String]()
    var selectedRoomId = ""
    var hotelId = ""
    
    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        setUpFromDatePicker()
        setUpToDatePicker()
        getRoomDetails()
    }
    

    //MARK: -IBActions
    @IBAction func reserveBtnPreseed(_ sender: UIButton) {
        
        if !fromTF.text!.isEmpty && !toTF.text!.isEmpty {
            
            postReservasion()
        } else {
            
            showAlert(message: "You must enter your visit duration")
        }
        
    }
    
    @objc func fromTFdatePicked(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        fromTF.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
    }
    
    @objc func toTFdatePicked(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        toTF.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
    }
    
    @objc func endPicking(tapGestureRecognizer: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    //MARK: -API Calls
    func getRoomDetails() {
        
        guard let url = URL(string: "\(offlineURL)/rooms/\(selectedRoomId)") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)
        //print("Activities \(alamoHeader)")
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                
                let repValue = response.value as? Dictionary<String,Any>
                let room = repValue!["room"] as? Dictionary<String,Any>
//                print(room!)
//                print(room!["bed"])
                self.roomImagesArray = room!["media"] as! [String]
                //print(self.roomImagesArray)
                self.bedLabel.text = room!["bed"] as? String
                self.mealsLabel.text = room!["food"] as? String
                //self.reserveBtnOutlet.setTitle("\(String(describing: room!["price"]!)) Reserve" , for: .normal)
                self.roomNumLabel.text = room!["number"] as? String
                self.roomPriceLabel.text = "\(String(describing: room!["price"]!)) L.E"
                self.mainRoomCollectionView.reloadData()
                
            case .failure(_):
                
                print(response.error?.localizedDescription ?? "Error")
            }
        }
    }
    
    func postReservasion() {
        
        
        guard let url = URL(string: "\(offlineURL)/hotels/\(hotelId)/request") else {return}
        
        print(url)
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        let params: [String: AnyObject] = ["roomId": selectedRoomId,
                                           "from": fromTF.text ?? "",
                                           "to": toTF.text ?? ""] as [String: AnyObject]
        
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                                
                switch response.result {
                    
                case .success(_):
                    
                    let responseJSON = JSON(response.value as Any)
                    print("postReservasion: \(responseJSON)")
                    if response.response?.statusCode == 201 {
                        self.showAlert(message: "Created")
                    }
                case .failure(_):
                    //print(response.debugDescription)
                    print(response.error?.localizedDescription ?? "Error")
                }
        }
    }
    
    
    
    //MARK: - Helper Functions
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Room"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    func setUpFromDatePicker() {
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(fromTFdatePicked(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endPicking(tapGestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        fromTF.inputView = datePicker
    }
    
    func setUpToDatePicker() {
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(toTFdatePicked(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endPicking(tapGestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        toTF.inputView = datePicker
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}


extension RoomVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        roomImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = mainRoomCollectionView.dequeueReusableCell(withReuseIdentifier: "MainRoomCVCell", for: indexPath) as! MainRoomCVCell
        
        cell.mainRoomImageView.image = getImage(from: roomImagesArray[indexPath.row])
    
        return cell
    }
    
    
}
