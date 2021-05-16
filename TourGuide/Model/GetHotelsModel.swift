//
//  GetHotelsModel.swift
//  TourGuide
//
//  Created by samaa on 30/04/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetHotels {
    
    let id: String?
    let name: String?
    let media: [String]?
    
    init(hotels: Dictionary<String,Any>) {
        
        self.id = hotels["id"] as? String
        self.name = hotels["name"] as? String
        self.media = hotels["media"] as? [String]
    }
    
}
