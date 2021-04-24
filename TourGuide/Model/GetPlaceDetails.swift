//
//  GetPlaceDetails.swift
//  TourGuide
//
//  Created by samaa on 19/04/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetPlaceDetails {
    
    let id: String?
    let name: String?
    let media: [String]?
    let description: String?
    let questions: [String]?
    let rate: Double?
    let hours: [Dictionary<String,Any>]
    let reviews: [Dictionary<String,Any>]
    
    init(place: Dictionary<String,Any>) {
        
        self.id = place["id"] as? String
        self.name = place["name"] as? String
        self.media = place["media"] as? [String]
        self.description = place["description"] as? String
        self.questions = place["questions"] as? [String]
        self.rate = place["rate"] as? Double
        self.hours = (place["hours"] as? [Dictionary<String,Any>])!
        self.reviews = (place["reviews"] as? [Dictionary<String,Any>])!

    }
    
}
