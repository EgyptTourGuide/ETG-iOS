//
//  PlaceDetailsVC.swift
//  TourGuide
//
//  Created by samaa on 11/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation

class PlaceDetailsVC: UIViewController, CLLocationManagerDelegate {

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
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var desriptionLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var placeMapView: MKMapView!
    @IBOutlet weak var ticketLabel: UILabel!
    
    //MARK: -Variables
    var placeId = ""
    var questionsArr = [String]()
    var daysArr = [String]()
    var fromArr = [String]()
    var toArr = [String]()
    var hoursArr = [String]()
    var commentsArr = [String]()
    var reviewerNames = [String]()
    var reviewerPictures = [String]()
    var foreignsTicketPrice = ""
    var egyptionsTicketPrice = ""
    var foreignsTicketcurrency = ""
    var egyptionsTicketcurrencye = ""

    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 200
    var placeName = ""
    var customCoordinate = CLLocationCoordinate2D(latitude: 30.805081, longitude: 30.9952908)

    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        setUpLocationManager()
        //configureLocationServices()
        //centerMapOnCenterLocation()
        addCustomPlaceAnnotation()
        get_placeDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        postFavorite()
    }

    //MARK: -IBActions
    
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        
        let reviewVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "ReviewVC") as! ReviewVC
        
        if !questionsArr.isEmpty, !placeId.isEmpty {
        reviewVC.questionsArr = self.questionsArr
        reviewVC.placeId = self.placeId
        reviewVC.id = self.placeId
        }
        
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
    
    @IBAction func egyptionsTicketBtnPressed(_ sender: UIButton) {
        
        self.ticketLabel.text = "\(self.egyptionsTicketPrice) \(self.egyptionsTicketcurrencye)"

    }
    @IBAction func foreignsTicketBtnPressed(_ sender: UIButton) {
        
        self.ticketLabel.text = "\(self.foreignsTicketPrice) \(self.foreignsTicketcurrency)"

    }
    
    //MARK: -API Calls
    func get_placeDetails() {

        guard let url = URL(string: "\(offlineURL)/places/\(placeId)") else {return}

        //print(url)
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let alamoHeader = HTTPHeaders(header)

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: alamoHeader).responseJSON { (response) in

            switch response.result {

            case .success(_):

                let repValue = response.value as? Dictionary<String,AnyObject>
                let place = repValue!["place"] as? Dictionary<String,AnyObject>
                let getPlaceDetails = GetPlaceDetails(place: place!)
                //print("Place: \(place!)")
                
                self.placeName = getPlaceDetails.name!
                self.placeLabel.text = getPlaceDetails.name
                self.rateLabel.text = "\(getPlaceDetails.rate ?? 0)"
                self.desriptionLabel.text = getPlaceDetails.description
                self.placeImageView.image = getImage(from: getPlaceDetails.media![0])
                //print(getPlaceDetails.ticket["foreign"]!)
                let foreignTicket = getPlaceDetails.ticket["foreign"]! as? Dictionary<String,AnyObject>
                let egyptionsTicket = getPlaceDetails.ticket["egyptian"]! as? Dictionary<String,AnyObject>
                self.foreignsTicketPrice = foreignTicket?["price"] as! String
                self.foreignsTicketcurrency = foreignTicket?["currency"] as! String
                self.egyptionsTicketPrice = egyptionsTicket?["price"] as! String
                self.egyptionsTicketcurrencye = egyptionsTicket?["currency"] as! String
                self.ticketLabel.text = "\(self.egyptionsTicketPrice) \(self.egyptionsTicketcurrencye)"
                //print(self.foreignsTicketPrice, self.foreignsTicketcurrency, self.egyptionsTicketPrice, self.egyptionsTicketcurrencye)
                //print(getPlaceDetails.location["coordinates"]!)
                let coordinates = getPlaceDetails.location["coordinates"] as! [Double]
                let latitude = coordinates[0]
                let longitude = coordinates[1]
                self.customCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                //print(coordinates[0])
                if let quesArr = getPlaceDetails.questions {
                    self.questionsArr = quesArr

                }
                //print(self.questionsArr)
                
                let hours = getPlaceDetails.hours
                for hour in hours {
                    
                    self.daysArr.append(hour["day"] as! String)
                    self.fromArr.append(hour["from"] as! String)
                    self.toArr.append(hour["to"] as! String)
                    
                }
                
                for day in 0..<self.daysArr.count {
                    self.hoursArr.append("\(self.daysArr[day]), from \(self.fromArr[day]) to \(self.toArr[day]) \n")
                    
                }
                
                //let the array of strings "hours" be one string
                let joined = self.hoursArr.joined()
                self.hourLabel.text = joined
                //print(self.daysArr, self.fromArr, self.toArr)
                //print(getPlaceDetails.hours)
                
                let reviews = getPlaceDetails.reviews
                for review in reviews {
                    
                    self.commentsArr.append(review["comment"] as! String)
                    //print(review["user"] as Any)
                    let reviewer = review["user"] as! Dictionary<String,Any>
                    self.reviewerNames.append(reviewer["name"] as! String)
                    self.reviewerPictures.append(reviewer["picture"] as! String)
                    }
                
                self.commentsTableView.reloadData()
                //print(getPlaceDetails.reviews)
                
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
        
        
        
        let params: [String: AnyObject] = ["type": "place",
                                           "id": placeId] as [String: AnyObject]
        
        
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
    
    
    //MARK: -Helper Functions
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Place"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        placeMapView.mapType = .standard
    }
    
}


extension PlaceDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commentsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "CommentsTVCell", for: indexPath) as! CommentsTVCell
        cell.commentLabel.text = commentsArr[indexPath.row]
        cell.nameLabel.text = reviewerNames[indexPath.row]
        cell.profileImage.image = getImage(from: reviewerPictures[indexPath.row])?.circleMasked
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return commentsTableView.frame.height
    }
    
}

extension PlaceDetailsVC: MKMapViewDelegate {
    
    func configureLocationServices() {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func centerMapOnCenterLocation()  {
        
        guard let myLocation = locationManager.location?.coordinate else { return }
        
        let coordinateRegion = MKCoordinateRegion(center: myLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        placeMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addCustomPlaceAnnotation()  {
        let annotation = DroppablePin(coordinate: customCoordinate, identifire: "droppablePin", subtitle: "This is \(placeName)", title: placeName)
        
        //var an: MKAnnotation?
        
        placeMapView.addAnnotation(annotation)
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
