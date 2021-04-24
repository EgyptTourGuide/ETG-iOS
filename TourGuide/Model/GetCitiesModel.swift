//
//  GetCitiesModel.swift
//  TourGuide
//
//  Created by samaa on 04/04/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetCity {
    
    let id: String?
    let name: String?
    let media: [String]?
    let description: String?
    
    init(cities: Dictionary<String,Any>) {
        
        self.id = cities["id"] as? String
        self.name = cities["name"] as? String
        self.media = cities["media"] as? [String]
        self.description = cities["description"] as? String
    }
    
}


struct GetCities: Codable {
    
    let id: String?
    let name: String?
    let media: [String]?
    let description: String?
    
}
