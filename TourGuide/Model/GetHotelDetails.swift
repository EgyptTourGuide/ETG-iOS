//
//  GetHotelDetails.swift
//  TourGuide
//
//  Created by samaa on 29/04/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetHotelDetails {
    
    let id: String?
    let name: String?
    let media: [String]?
    let description: String?
    let rate: Double?
    let rooms: [Dictionary<String,Any>]
    let reviews: [Dictionary<String,Any>]
    let questions: [String]?

    init(hotel: Dictionary<String,Any>) {
        
        self.id = hotel["id"] as? String
        self.name = hotel["name"] as? String
        self.media = hotel["media"] as? [String]
        self.description = hotel["description"] as? String
        self.rate = hotel["rate"] as? Double
        self.rooms = (hotel["rooms"] as? [Dictionary<String,Any>])!
        self.reviews = (hotel["reviews"] as? [Dictionary<String,Any>])!
        self.questions = hotel["questions"] as? [String]

    }
    
}
