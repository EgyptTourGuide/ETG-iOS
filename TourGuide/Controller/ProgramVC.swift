//
//  ProgramVC.swift
//  TourGuide
//
//  Created by samaa on 27/03/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class ProgramVC: UIViewController {

    //MARK: -IBOutlets
    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var tourTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var tourDescrLabel: UILabel!
    @IBOutlet weak var tourPrice: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var featuresCollectionView: UICollectionView!
    @IBOutlet weak var toursCollectionView: UICollectionView!
    @IBOutlet weak var checkAvaliabiltyBtnOutlet: UIButton! {
        didSet {
            checkAvaliabiltyBtnOutlet.layer.cornerRadius = checkAvaliabiltyBtnOutlet.frame.height / 2
        }
    }
    @IBOutlet weak var checkView: UIView! {
        didSet {
            checkView.layer.cornerRadius = 10
            checkView.isHidden = true
        }
    }
    @IBOutlet weak var startdateTF: UITextField!
    @IBOutlet weak var personsNumTF: UITextField!
    @IBOutlet weak var hotelQuesTF: UITextField!
    @IBOutlet weak var yesBtnOutlet: UIButton!
    @IBOutlet weak var noBtnOutlet: UIButton!
    @IBOutlet weak var egyPriceLabel: UILabel!
    
    @IBOutlet weak var foriegnPriceLabel: UILabel!
    @IBOutlet weak var checkViewBtnOutlet: UIButton! {
        didSet {
            checkViewBtnOutlet.layer.cornerRadius = checkViewBtnOutlet.frame.height / 2
            
        }
    }
    @IBOutlet weak var commentsTableView: UITableView!

    @IBOutlet weak var addReviewBtnOutlet: UIButton! {
        didSet{
            addReviewBtnOutlet.layer.cornerRadius = addReviewBtnOutlet.frame.height / 2
        }
    }
    var datePicker: UIDatePicker?
    var picker : UIPickerView?

    //MARK: -Variables
    var cityId = ""
    var getPlanArr = [GetPlans]()
    var foreignsTicketPrice = ""
    var egyptionsTicketPrice = ""
    var featuresArray = [String]()
    var tourImagesArr = [String]()
    var planId = ""
    var fromArr = [String]()
    var toArr = [String]()
    var placesNamesArr = [String]()
    var placesMediaArr = [String]()
    var days = [String]()
    var persons = ""
    var date = ""
    var hotelAnswer: Bool?
    var questionsArr = [String]()
    var commentsArr = [String]()
    var reviewerNames = [String]()
    var reviewerPictures = [String]()
    
    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        getPlansOrHotels()
        getPlans()
        setUpStartDatePicker()
        setUpCkeckView()
        //print(cityId)
    }
    
    
    //MARK: -IBActions
    @IBAction func egyptionsTicketBtnPressed(_ sender: UIButton) {
        
        self.tourPrice.text = "\(self.foreignsTicketPrice) EGP"
        
    }
    @IBAction func foreignsTicketBtnPressed(_ sender: UIButton) {
        
        self.tourPrice.text = "\(self.egyptionsTicketPrice) $"
        
    }
    
    @IBAction func checkAvaiabiltyBtnPressed(_ sender: UIButton) {
        
        checkView.isHidden = false
    }
    
    @IBAction func hideViewBtnPressed(_ sender: UIButton) {
        checkView.isHidden = true
    }
    
    @objc func startDateTFdatePicked(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startdateTF.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
    }
    
    @objc func endPicking(tapGestureRecognizer: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    @IBAction func yesOrNoBtnPressed(_ sender: UIButton) {
        
        if sender == yesBtnOutlet {
            hotelQuesTF.text = "true"
            hotelAnswer = true
//            noBtnOutlet.isEnabled = false
        } else if sender == noBtnOutlet {
            hotelQuesTF.text = "false"
            hotelAnswer = false
//            yesBtnOutlet.isEnabled = false
        }
    }
    
    @IBAction func check_viewBtnPressed(_ sender: UIButton) {
        post_check()
    }
    
    @IBAction func addReviewBtnPressed(_ sender: UIButton) {
        let reviewVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "ReviewVC") as! ReviewVC
        
        if !questionsArr.isEmpty, !planId.isEmpty {
        reviewVC.questionsArr = self.questionsArr
        reviewVC.planId = self.planId
        reviewVC.id = self.planId
        }
        
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    //MARK: -API Calls
    
    func getPlansOrHotels() {
        
        guard let url = URL(string: "\(offlineURL)/profile/plans") else {return}
        
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                switch response.result {
                    
                case .success(_):
                    //                    let repValue = response.value as AnyObject
                    //                    print("Plans success \(repValue)")
                    print("Success")
                    
                case .failure(_):
                    print(response.error?.localizedDescription ?? "Eroor: Failure")
                }
        }
        
    }
    
    func getPlans() {
        
        guard let url = URL(string: "\(offlineURL)/plans/\(planId)") else {return}
        
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: alamoHeader)
            .responseJSON { (response) in
                switch response.result {
                    
                case .success(_):
                    
                    let repValue = response.value as? Dictionary<String,AnyObject>
                    let plan = repValue!["plan"] as? Dictionary<String,AnyObject>
                    let getProgramDetails = GetPlans(plan: plan!)
                    print(getProgramDetails)
                    let city = getProgramDetails.city
                    self.cityName.text = city["name"] as? String
                    self.tourTitleLabel.text = getProgramDetails.title
                    self.cityImageView.image = getImage(from: getProgramDetails.media![0])
                    self.rateLabel.text = "\(getProgramDetails.rate ?? 0)"
                    self.tourDescrLabel.text = getProgramDetails.description
                    let ticket = getProgramDetails.ticket
                    self.foreignsTicketPrice = ticket["foreign"] as! String
                    self.egyptionsTicketPrice = ticket["egyptian"] as! String
                    self.egyPriceLabel.text = "\(ticket["egyptian"] as! String) EGP"
                    self.foriegnPriceLabel.text = "\(ticket["foreign"] as! String) USD"

                    self.tourPrice.text = self.egyptionsTicketPrice
                    let duration = getProgramDetails.duration

                    if let days = duration["days"] {
                        self.daysLabel.text = "\(String(describing: days as! Double))"
                    }

                    if let hours = duration["hours"] {
                        self.hoursLabel.text = "\(String(describing: hours as! Double))"
                    }

                    if let features = getProgramDetails.features {
                        self.featuresArray = features
                    }

                    if let media = getProgramDetails.media {
                        self.tourImagesArr = media
                    }
                    
                    let tours = getProgramDetails.tour
                    for tour in tours {
                        
                        self.fromArr.append(tour["from"] as! String)
                        self.toArr.append(tour["to"] as! String)
                        let place = tour["place"] as! Dictionary<String,Any>
                        self.placesNamesArr.append(place["name"] as! String)
                        let media = place["media"] as! [String]
                        self.placesMediaArr.append(media[0])
                        self.days.append(tour["day"] as! String)
                    }
                    if let quesArr = getProgramDetails.questions  {
                        self.questionsArr = quesArr
                    }
                    
                    let reviews = getProgramDetails.reviews
                    for review in reviews {
                        
                        self.commentsArr.append(review["comment"] as! String)
                        //print(review["user"] as Any)
                        let reviewer = review["user"] as! Dictionary<String,Any>
                        self.reviewerNames.append(reviewer["name"] as! String)
                        self.reviewerPictures.append(reviewer["picture"] as! String)
                        }
                    self.toursCollectionView.reloadData()
                    self.featuresCollectionView.reloadData()
                    
                case .failure(_):
                    print(response.error?.localizedDescription ?? "Eroor: Failure")
                }
        }
        
    }
    
    func post_check() {
        
        startLoading()
        
        guard let url = URL(string: "\(offlineURL)/plans/\(planId)/check") else {return}
        
        let header = Constants().defaultHeader
        let APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        //        print("getFavToken: \(APIToken)")
        let authorization = Constants().authHeader(authToken: APIToken)
        //        print(header, authorization)
        let alamoHeader = APIHandler.checkHeaders(headers: header, authorization: authorization)
        
        ckeckTFs()
        var params : [String : Any]?
        if days[0] != "0" {
            if let hotel = hotelAnswer {
                params = ["start": date,
                          "persons": persons,
                          "withHotel": hotel]
            }
        } else {
            params = ["start": date,
            "persons": persons]
        }
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: alamoHeader, interceptor: CustomInterceptor())
        .validate(statusCode: 200...300)
        .responseJSON { (response) in
            
            self.dismiss(animated: true, completion: nil)
            switch response.result {
                
            case .success(_):
                print("Success")
                let repValue = response.value as! Dictionary<String,Any>
                let available = repValue["available"] as! Bool
                if available == false {
                    let message = repValue["msg"] as! String
                    self.showAlert(message: message)
                } else if available == true {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let confirmDeclinePlanVC = UIStoryboard(name: "AddNewPlane", bundle: nil).instantiateViewController(identifier: "ConfirmDeclinePlanVC") as! ConfirmDeclinePlanVC
                        confirmDeclinePlanVC.planDetails = repValue
                        confirmDeclinePlanVC.planId = self.planId
                        self.navigationController?.pushViewController(confirmDeclinePlanVC, animated: true)
                    }
                    print(repValue)
                }
                
            case .failure(_):
                print(response.error?.localizedDescription ?? "Error ")
            }
        }
    }
    
    //MARK: -Helper Functions

    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Program"

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setUpCkeckView() {
        
        personsNumTF.keyboardType = .numberPad
        personsNumTF.becomeFirstResponder()
        for day in days {
            if day == "0" {
                self.hotelQuesTF.text = "one day tour"
                self.hotelQuesTF.isEnabled = false
                self.yesBtnOutlet.isEnabled = false
                self.noBtnOutlet.isEnabled = false
            } else if day != "0" {
                hotelQuesTF.attributedPlaceholder = NSAttributedString(string: "want hotel?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(1)])
                self.hotelQuesTF.isEnabled = false
                self.yesBtnOutlet.isEnabled = false
                self.noBtnOutlet.isEnabled = false
            }
        }
//        if let num = Int(personsNumTF.text!) {
//            let egyPrice = Int(egyptionsTicketPrice)
//            let foreignPrice = Int(foreignsTicketPrice)
//            egyPriceLabel.text = "\(num * egyPrice!)"
//            foriegnPriceLabel.text = "\(num * foreignPrice!)"
//        }
        
        
    }
    
    func setUpStartDatePicker() {
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(startDateTFdatePicked(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endPicking(tapGestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        startdateTF.inputView = datePicker
    }
    
    func ckeckTFs() {
        if !startdateTF.text!.isEmpty, !personsNumTF.text!.isEmpty {
            self.date = startdateTF.text!
            self.persons = personsNumTF.text!
        } else {
            self.showAlert(message: "You should write the date and persons number")
        }
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


    func startLoading() {
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ProgramVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == featuresCollectionView {
            return featuresArray.count
        } else {
            return placesNamesArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == featuresCollectionView {
            
            let cell = featuresCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesCVCell", for: indexPath) as! FeaturesCVCell
            cell.featuresLabel.text = featuresArray[indexPath.row]
            
            return cell
        } else {
            
            let cell = toursCollectionView.dequeueReusableCell(withReuseIdentifier: "TourCVCell", for: indexPath) as! TourCVCell
            
            cell.tourImageView.image = getImage(from: placesMediaArr[indexPath.row])
            for day in days {
                if day == "0" {
                    cell.dayLabel.text = "Day 1"
                } else {
                    cell.dayLabel.text = "Day \(days[indexPath.row])"
                }
            }
            cell.placeNameLabel.text = placesNamesArr[indexPath.row]
            cell.fromLabel.text = "\(fromArr[indexPath.row]) to "
            cell.toLabel.text = toArr[indexPath.row]
            return cell
        }
    }
    
}

extension ProgramVC: UITableViewDelegate, UITableViewDataSource {
    
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


