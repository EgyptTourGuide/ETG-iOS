//
//  HelperFunctions.swift
//  TourGuide
//
//  Created by samaa on 07/04/2021.
//  Copyright © 2021 samaa. All rights reserved.
//


import UIKit

func getImage(from string: String) -> UIImage? {
    //2. Get valid URL
    guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
    }

    var image: UIImage? = nil
    do {
        //3. Get valid data
        let data = try Data(contentsOf: url, options: [])

        //4. Make image
        image = UIImage(data: data)
    }
    catch {
        print(error.localizedDescription)
    }

    return image
}
