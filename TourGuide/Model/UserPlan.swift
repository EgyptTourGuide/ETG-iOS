//
//  UserPlan.swift
//  TourGuide
//
//  Created by samaa on 12/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class UserPlan {
    
    let city: Dictionary<String,Any>
    let id: String?
    let price: String?
    let persons: String?
    let plan: Dictionary<String,Any>
    let transport: Dictionary<String,Any>
    
    init(plan: Dictionary<String,Any>) {
        
        self.city = (plan["city"] as? Dictionary<String,Any>)!
        self.id = plan["id"] as? String
        self.price = plan["price"] as? String
        self.persons = plan["price"] as? String
        self.plan = (plan["plan"] as? Dictionary<String,Any>)!
        self.transport = (plan["transport"] as? Dictionary<String,Any>)!

    }
    
}
