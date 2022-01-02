//
//  Constants.swift
//  TourGuide
//
//  Created by samaa on 09/02/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let onlineURL = "https://egypttourguide.herokuapp.com"
let offlineURL = "http://192.168.43.149:3001"
class Constants{
    
    let defaultHeader = ["Content-Type":"application/json; charset=utf-8"]
    
    func authHeader(authToken: String) -> [String:String] {
        
        return ["authorization":authToken]
    }
}
