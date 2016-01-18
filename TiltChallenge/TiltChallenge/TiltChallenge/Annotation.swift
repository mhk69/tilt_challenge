//
//  Annotation.swift
//  TiltChallenge
//
//  Created by Matt Klein on 1/16/16.
//  Copyright © 2016 MattKlein. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
}