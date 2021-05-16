//
//  HotelVC.swift
//  TourGuide
//
//  Created by samaa on 01/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class HotelVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelRate: UILabel!
    @IBOutlet weak var hotelDescription: UILabel!
    
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewsTableView: UITableView! {
        didSet {
            reviewsTableView.layer.borderWidth = 2
            reviewsTableView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            reviewsTableView.layer.cornerRadius = 10
        }
    }
    
    
    @IBOutlet weak var addReviewBtnOutlet: UIButton! {
        didSet {
            addReviewBtnOutlet.layer.cornerRadius = addReviewBtnOutlet.frame.height / 2
        }
    }
    
    
    //MARK: -Variables
    var roomImagesArray = [String]()
    var hotelId = ""
    var getRoomArr = [GetRooms]()
    var commentsArr = [String]()
    var reviewerNames = [String]()
    var reviewerPictures = [String]()
    var questionsArr = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        get_hotelDetails()
    }
    

    //MARK: -IBActions
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        let reviewVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "ReviewVC") as! ReviewVC
        
        reviewVC.questionsArr = self.questionsArr
        
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    
    
    //MARK:- Helper Functions
    
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Hotel"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func get_hotelDetails() {

        guard let url = URL(string: "https://egypttourguide.herokuapp.com/hotels/\(hotelId)") else {return}

        print(url)
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in

            switch response.result {

            case .success(_):
                
                let hotel = response.value as AnyObject
                //print(hotel)
            
                let getHotelDetails = GetHotelDetails(hotel: hotel as! Dictionary<String, Any>)
                self.hotelName.text = getHotelDetails.name
                self.hotelRate.text = "\(getHotelDetails.rate ?? 0)"
                self.hotelDescription.text = getHotelDetails.description
                self.hotelImage.image = getImage(from: getHotelDetails.media![0])
                //print(getHotelDetails.questions as Any)
                self.questionsArr = getHotelDetails.questions!
                
                let rooms = getHotelDetails.rooms
                for room in rooms {

                    let getRoom = GetRooms(rooms: room)
                    self.getRoomArr.append(getRoom)
//                    self.roomImagesArray.append(getRoom.media![0])
                    
                    }
                //print(self.getRoomArr)
                let reviews = getHotelDetails.reviews
                for review in reviews {
                    
                    self.commentsArr.append(review["comment"] as! String)
                    let reviewer = review["user"] as! Dictionary<String,Any>
                    self.reviewerNames.append(reviewer["name"] as! String)
                    self.reviewerPictures.append(reviewer["picture"] as! String)
                    //print(review["user"] as Any)
                    
                    }
                //print(self.reviewerNames)

                self.reviewsTableView.reloadData()

                self.roomCollectionView.reloadData()
                //print(getHotelDetails.rooms)
                
            case .failure(_):

                print(response.error?.localizedDescription ?? "Error: Failure")
            }
        }
    }

}

extension HotelVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return getRoomArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = roomCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomCVCell", for: indexPath) as! RoomCVCell
//        cell.roomImgeView.image = getImage(from: roomImagesArray[indexPath.row])
        cell.reserveBtnOutlet.setTitle("\(getRoomArr[indexPath.row].price!) LE", for: .normal)
        cell.nimOfMealsLabel.text = getRoomArr[indexPath.row].food
        cell.numOfBedsLabel.text = getRoomArr[indexPath.row].bed
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let roomVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "RoomVC") as! RoomVC
        roomVC.getRoomArr = self.getRoomArr
        
        self.navigationController?.pushViewController(roomVC, animated: true)
    }
}


extension HotelVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commentsArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reviewsTableView.dequeueReusableCell(withIdentifier: "CommentsTVCell", for: indexPath) as! CommentsTVCell
        cell.commentLabel.text = commentsArr[indexPath.row]
        cell.nameLabel.text = reviewerNames[indexPath.row]
        cell.profileImage.image = getImage(from: reviewerPictures[indexPath.row])?.circleMasked
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return reviewsTableView.frame.height
    }
    
}
