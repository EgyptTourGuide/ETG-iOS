//
//  GetRoom.swift
//  TourGuide
//
//  Created by samaa on 08/05/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetRooms {
    
    let id: String?
    let bed: String?
    let media: [String]?
    let price: Double?
    let food: String?
    let number: String?

    
    init(rooms: Dictionary<String,Any>) {
        
        self.id = rooms["id"] as? String
        self.bed = rooms["bed"] as? String
        self.media = rooms["media"] as? [String]
        self.price = rooms["price"] as? Double
        self.food = rooms["food"] as? String
        self.number = rooms["number"] as? String

    }
    
}
