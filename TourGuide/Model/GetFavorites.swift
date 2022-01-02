//
//  GetFavorites.swift
//  TourGuide
//
//  Created by samaa on 28/05/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetFavorites {
    
    let id: String?
    let name: String?
    let media: [String]?
    let type: String?
    
    init(favorite: Dictionary<String,Any>) {
        
        self.id = favorite["id"] as? String
        self.name = favorite["name"] as? String
        self.media = favorite["media"] as? [String]
        self.type = favorite["type"] as? String

    }
    
}
