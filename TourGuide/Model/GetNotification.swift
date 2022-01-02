//
//  GetNotification.swift
//  TourGuide
//
//  Created by samaa on 06/06/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetNotification {
    
    let id: String?
    let title: String?
    let content: String?
    
    init(notification: Dictionary<String,Any>) {
        
        self.id = notification["id"] as? String
        self.title = notification["title"] as? String
        self.content = notification["content"] as? String

    }
    
}
