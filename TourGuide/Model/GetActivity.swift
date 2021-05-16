//
//  GetActivity.swift
//  TourGuide
//
//  Created by samaa on 08/05/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetActivity {
    
    let id: String?
    let name: String?
    let media: [String]?
    
    init(activity: Dictionary<String,Any>) {
        
        self.id = activity["id"] as? String
        self.name = activity["name"] as? String
        self.media = activity["media"] as? [String]

    }
    
}
