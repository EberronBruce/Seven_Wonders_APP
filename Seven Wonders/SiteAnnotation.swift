//
//  SiteAnnotation.swift
//  Seven Wonders
//
//  Created by Bruce Burgess on 7/7/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

/*
   This class is just used to hold the coordinates for each annotation for the map to mark each site.
 */

import Foundation
import MapKit

class SiteAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
