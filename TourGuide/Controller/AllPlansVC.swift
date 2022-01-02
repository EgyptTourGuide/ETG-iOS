//
//  AllPlansVC.swift
//  TourGuide
//
//  Created by samaa on 09/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import UIKit
import Alamofire

class AllPlansVC: UIViewController {

    @IBOutlet weak var plansCollectionView: UICollectionView!
    
    //MARK: -Variables
    var cityId = ""
    var getPlanArr = [GetPlans]()
    var plansImgsArr = [String]()
    var duration = Dictionary<String,Any>()
    var ticket = Dictionary<String,Any>()
    var selectedPlanId = ""

    //MARK: -View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        getPlans()
    }
    

    //MARK: -API Calls
    func getPlans() {
      
      guard let url = URL(string: "\(offlineURL)/plans?city=\(cityId)") else {return}
      
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
                  let repValue = response.value as? Dictionary<String,AnyObject>
                  let plans = repValue!["plans"] as? [Dictionary<String,AnyObject>]
                  //                      print(plans!)
                  //                      print("plans Success")
                  
                  for plan in plans! {
                      
                    let getPlan = GetPlans(plan: plan)
                    self.getPlanArr.append(getPlan)
                    self.duration = getPlan.duration
                    self.ticket = getPlan.ticket
                    if let media = getPlan.media {
                        self.plansImgsArr.append(media[0])
                    }
                    
                }
                 
                  self.plansCollectionView.reloadData()
              case .failure(_):
                    print(response.error?.localizedDescription ?? "Eroor: Failure")
                }
        }
        
    }
    
    //MARK: -Helper Functions
    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = "Plans"
        
        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }


}

extension AllPlansVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getPlanArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = plansCollectionView.dequeueReusableCell(withReuseIdentifier: "AllPlansCVCell", for: indexPath) as! AllPlansCVCell
        cell.planName.text = getPlanArr[indexPath.row].title
        cell.tourImageView.image = getImage(from: plansImgsArr[indexPath.row])
        cell.Duration_hoursLabel.text = "\(duration["hours"] as! Double) hours"
        cell.egyPriceLabel.text = "\(ticket["egyptian"] as! String) EGP"
        cell.foriegnPriceLabel.text = "\(ticket["foreign"] as! String) USD"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let programVC = UIStoryboard(name: "AddNewPlane", bundle: nil).instantiateViewController(identifier: "ProgramVC") as! ProgramVC
        
        if let planId = getPlanArr[indexPath.row].id {
            
            self.selectedPlanId = planId
            //print("selected \(selectedPlaceId)")
        }
        
        print(selectedPlanId)
        programVC.planId = selectedPlanId
        self.navigationController?.pushViewController(programVC, animated: true)
    }
    
}
