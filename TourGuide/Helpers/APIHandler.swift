//
//  APIHandler.swift
//  RetrierAdapterEx
//
//  Created by samaa on 21/05/2021.
//  Copyright © 2021 samaa. All rights reserved.
//

import Foundation
import Alamofire

class APIHandler {
    
     class func checkHeaders(headers: [String:String]? = nil, authorization: [String:String]? = nil) -> HTTPHeaders? {
        
        var myHeader: HTTPHeaders? = nil
        var dicHeader = Constants().defaultHeader
        
        if let dic = headers {
            for item in dic {
                dicHeader[item.key] = item.value
            }
        }
        
        if let dic = authorization {
            for item in dic {
                dicHeader[item.key] = item.value
            }
        }
        
        myHeader = HTTPHeaders(dicHeader)
        return myHeader
    }

}
