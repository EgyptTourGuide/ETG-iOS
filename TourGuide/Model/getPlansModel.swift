//
//  getPlansModel.swift
//  TourGuide
//
//  Created by samaa on 08/07/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation

class GetPlans {
    
    let city: Dictionary<String,Any>
    let id: String?
    let title: String?
    let media: [String]?
    let description: String?
    let rate: Double?
    let ticket: Dictionary<String,Any>
    let duration: Dictionary<String,Any>
    let features: [String]?
    let tour: [Dictionary<String,Any>]
    let questions: [String]?
    let reviews: [Dictionary<String,Any>]

//    let questions: [String]
//    let reviews: [String]

    init(plan: Dictionary<String,Any>) {
        
        self.city = (plan["city"] as? Dictionary<String,Any>)!
        self.id = plan["id"] as? String
        self.title = plan["title"] as? String
        self.media = plan["media"] as? [String]
        self.description = plan["description"] as? String
        self.rate = plan["rate"] as? Double
        self.ticket = (plan["ticket"] as? Dictionary<String,Any>)!
        self.duration = (plan["duration"] as? Dictionary<String,Any>)!
        self.tour = (plan["tour"] as? [Dictionary<String,Any>])!
        self.features = plan["features"] as? [String]
        self.questions = plan["questions"] as? [String]
        self.reviews = (plan["reviews"] as? [Dictionary<String,Any>])!

        //        self.reviews = (hotel["reviews"] as? [Dictionary<String,Any>])!
        //        self.questions = hotel["questions"] as? [String]
    }

}
