//
//  WonderSite.swift
//  Seven Wonders
//
//  Created by Bruce Burgess on 7/6/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

/*
  This class is used to store the necessary data for each individual site which will be given by the JSON response
*/


import Foundation
import UIKit

class WonderSite {
    private var _name: String!
    private var _year_built: String!
    private var _photo: UIImage!
    private var _latitude: Double!
    private var _longitude: Double!
    private var _location: String!
    
    init(name: String, yearBuilt: String, location: String, photo: UIImage, latitude: Double, longitude: Double) {
        _name = name
        _year_built = yearBuilt
        _location = location
        _latitude = latitude
        _longitude = longitude
        _photo = photo
    }
    
    var name: String {
        return _name
    }
    
    var location: String{
        return _location
    }
    
    var year_built: String{
        return _year_built
    }
    
    var photo: UIImage {
        return _photo
    }
    
    var latitude: Double {
        return _latitude
    }
    
    var longitude: Double {
        return _longitude
    }
    
}