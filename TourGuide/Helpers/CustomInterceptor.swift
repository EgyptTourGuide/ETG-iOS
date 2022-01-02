//
//  CustomInterceptor.swift
//  TourGuide
//
//  Created by samaa on 21/05/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CustomInterceptor: RequestInterceptor {
    
    var APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
    let count = 2
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        let urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString,
            urlString.contains("/review") || urlString.contains("profile") {

            APIToken = UserDefaults.standard.string(forKey: "APIToken") ?? "There is no token"
        }
        
        completion(.success(urlRequest))

    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        if count < 2 {
            
            if let urlString = request.request?.url, urlString.absoluteString.contains("/review") || urlString.absoluteString.contains("/profile") || urlString.absoluteString.contains("/hotels") || urlString.absoluteString.contains("/confirm"), request.response?.statusCode == 403 {
                
                UserDefaults.standard.removeObject(forKey: "APIToken")
                postRefresh()
                print("Retry: \(APIToken)")
                UserDefaults.standard.set(APIToken, forKey: "APIToken")
                completion(.retry)
            }
        } else {
            completion(.doNotRetry)
        }
    }
    
    func postRefresh() {
        
        guard let url = URL(string: "\(offlineURL)/token") else {return}
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let AlamoHeader = HTTPHeaders(header)
        
        let refrechToken = UserDefaults.standard.string(forKey: "refreshToken") ?? "There is no token"

        let params : [String : Any] = ["refreshToken":refrechToken]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: AlamoHeader).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                let responseJSON = JSON(response.value as Any)
                self.APIToken = responseJSON["token"].stringValue
                print(self.APIToken)
            case .failure(_):
                print(response.error?.localizedDescription ?? "Error ")
            }
        }
        
    }
    
}

