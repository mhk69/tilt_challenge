//
//  VenueObject.swift
//  TiltChallenge
//
//  Created by Matt Klein on 1/16/16.
//  Copyright © 2016 MattKlein. All rights reserved.
//

import Foundation
import CoreLocation

class VenueObject : NSObject {
    var id = ""
    var name = ""
    
    var lat = 0.0
    var lng = 0.0
    
    var coordinate: CLLocation {
        return CLLocation(latitude: lat, longitude: lng)
    }
    
    init(id: String, name: String, lat: Double, lng: Double) {
        self.id = id
        self.name = name
        self.lat = lat
        self.lng = lng
    }
    
    
    
}