//
//  GetPlaceModel.swift
//  TourGuide
//
//  Created by samaa on 10/04/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetPlace {
    
    let id: String?
    let name: String?
    let media: [String]?
    let description: String?
    
    init(places: Dictionary<String,Any>) {
        
        self.id = places["id"] as? String
        self.name = places["name"] as? String
        self.media = places["media"] as? [String]
        self.description = places["description"] as? String
    }
    
}
