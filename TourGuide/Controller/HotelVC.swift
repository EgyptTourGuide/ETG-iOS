//
//  HotelVC.swift
//  TourGuide
//
//  Created by samaa on 01/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation

class HotelVC: UIViewController, CLLocationManagerDelegate {

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
    
    @IBOutlet weak var featuresCollectionView: UICollectionView!
    
    @IBOutlet weak var hotelMapView: MKMapView! 
    
    //MARK: -Variables
    var roomImagesArray = [String]()
    var hotelId = ""
    var getRoomArr = [GetRooms]()
    var commentsArr = [String]()
    var reviewerNames = [String]()
    var reviewerPictures = [String]()
    var questionsArr = [String]()
    var featuresArray = [String]()
    var selectedRoomId = ""
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 200
    var hotelN = ""
    var customCoordinate = CLLocationCoordinate2D(latitude: 30.805081, longitude: 30.9952908)

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        get_hotelDetails()
        setUpLocationManager()
        //configureLocationServices()
        //centerMapOnCenterLocation()
        addCustomPlaceAnnotation()
    }
    

    //MARK: -IBActions
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        let reviewVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "ReviewVC") as! ReviewVC
        
        reviewVC.questionsArr = self.questionsArr
        reviewVC.hotelId = self.hotelId
        reviewVC.id = self.hotelId
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    @IBAction func likeBtnPressed(_ sender: UIButton) {
           
           if sender.imageView?.image == #imageLiteral(resourceName: "likeIcon") {
               
               sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
               postFavorite()
           } else {
               sender.setImage(#imageLiteral(resourceName: "likeIcon"), for: .normal)
           }
       }
    
    @IBAction func openInMapsBtnPreesed(_ sender: UIButton) {
           
           let regionSpan = MKCoordinateRegion(center: customCoordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
           
           let options = [
               MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
               MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
           ]
           
           let placemark = MKPlacemark(coordinate: customCoordinate, addressDictionary: nil)
           let mapItem = MKMapItem(placemark: placemark)
           
           mapItem.name = "Your destination"
           mapItem.openInMaps(launchOptions: options)
       }
    
    //MARK: -API Calls
    func get_hotelDetails() {

        guard let url = URL(string: "\(offlineURL)/hotels/\(hotelId)") else {return}

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
                self.hotelN = getHotelDetails.name!
                self.hotelRate.text = "\(getHotelDetails.rate ?? 0)"
                self.hotelDescription.text = getHotelDetails.description
                self.hotelImage.image = getImage(from: getHotelDetails.media![0])
                //print(getHotelDetails.questions as Any)
                self.questionsArr = getHotelDetails.questions!
                self.featuresArray = getHotelDetails.features!
                let coordinates = getHotelDetails.location["coordinates"] as! [Double]
                let latitude = coordinates[0]
                let longitude = coordinates[1]
                self.customCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                //print(getHotelDetails.features!)
                //print("My Array: \(self.featuresArray)")
                let rooms = getHotelDetails.rooms
                for room in rooms {

                    let getRoom = GetRooms(rooms: room)
                    self.getRoomArr.append(getRoom)
                    self.roomImagesArray.append(getRoom.media![0])
                    
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
                self.featuresCollectionView.reloadData()
                
            case .failure(_):

                print(response.error?.localizedDescription ?? "Error: Failure")
            }
        }
    }
    
    func postFavorite() {
        
        
        guard let url = URL(string: "\(offlineURL)/profile/favourites") else {return}
        
        print(url)
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        
        
        let params: [String: AnyObject] = ["type": "hotel",
                                           "id": hotelId] as [String: AnyObject]
        
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                                
                switch response.result {
                    
                case .success(_):
                    
                    let responseJSON = JSON(response.value as Any)
                    print("postFavorites: \(responseJSON)")
                    
                    
                    
                case .failure(_):
                    //print(response.debugDescription)
                    print(response.error?.localizedDescription ?? "Error")
                }
        }
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
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        hotelMapView.mapType = .standard
    }
}

extension HotelVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == roomCollectionView {
            return getRoomArr.count
        } else {
            return featuresArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == roomCollectionView {
            
            let cell = roomCollectionView.dequeueReusableCell(withReuseIdentifier: "RoomCVCell", for: indexPath) as! RoomCVCell
            
            cell.roomImgeView.image = getImage(from: roomImagesArray[indexPath.row])
            cell.reserveBtnOutlet.setTitle("\(getRoomArr[indexPath.row].price!) L.E", for: .normal)
            cell.nimOfMealsLabel.text = getRoomArr[indexPath.row].food
            cell.numOfBedsLabel.text = getRoomArr[indexPath.row].bed
            
            return cell
            
        } else {
            let cell = featuresCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesCVCell", for: indexPath) as! FeaturesCVCell
            
            cell.featuresLabel.text = "- \(featuresArray[indexPath.row])"
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let roomVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "RoomVC") as! RoomVC
        
        if let roomId = getRoomArr[indexPath.row].id {
            self.selectedRoomId = roomId
        }
        roomVC.hotelId = hotelId
        roomVC.selectedRoomId = self.selectedRoomId
        self.navigationController?.pushViewController(roomVC, animated: true)
    }
}


extension HotelVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == reviewsTableView {
            
            return commentsArr.count
            
        } else {
            
            return featuresArray.count
        }
        
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


extension HotelVC: MKMapViewDelegate {
    
//    func configureLocationServices() {
//
//        locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
//    }
    
    func centerMapOnCenterLocation()  {
        
        guard let myLocation = locationManager.location?.coordinate else { return }
        
        let coordinateRegion = MKCoordinateRegion(center: myLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        hotelMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addCustomPlaceAnnotation()  {
        let annotation = DroppablePin(coordinate: customCoordinate, identifire: "droppablePin", subtitle: "This is \(hotelN)", title: hotelN)
        
        //var an: MKAnnotation?
        
        hotelMapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation is MKUserLocation {
            return nil
        }
        
        
        let annotationImage = #imageLiteral(resourceName: "Pin")
        
        let annotationReuseId = "droppablePin"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
        } else {
            anView!.annotation = annotation
        }
        anView!.image = annotationImage
        anView!.frame.origin.y = 100
        anView!.frame = CGRect(x: 0, y: 0 , width: 35, height: 35)
        anView!.centerOffset = CGPoint(x: 0, y: -20)
        anView!.backgroundColor = UIColor.clear
        anView!.canShowCallout = true
        
        
        return anView
        
    }
}

