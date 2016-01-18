//
//  LocationDeterminer.swift
//  TiltChallenge
//
//  Created by Matt Klein on 1/14/16.
//  Copyright © 2016 MattKlein. All rights reserved.
//

import Foundation
import QuadratTouch
import CoreLocation

class LocationParameters {
    static func details(location: CLLocation) -> Parameters {
        // Lots of .description - previously used it to be safe with things on the SDK I worked on
        let latLng = "\(location.coordinate.latitude.description),\(location.coordinate.longitude.description)"
        let latLngAccuracy = "\(location.horizontalAccuracy.description)"
        let altitude = "\(location.altitude.description)"
        let altitudeAccuracy = "\(location.verticalAccuracy.description)"
        
        return [
            Parameter.ll:latLng,
            Parameter.llAcc: latLngAccuracy,
            Parameter.alt: altitude,
            Parameter.altAcc: altitudeAccuracy
        ]
        
    }
}