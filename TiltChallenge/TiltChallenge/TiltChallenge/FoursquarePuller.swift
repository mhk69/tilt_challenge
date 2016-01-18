//
//  FoursquarePuller.swift
//  TiltChallenge
//
//  Created by Matt Klein on 1/16/16.
//  Copyright © 2016 MattKlein. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import QuadratTouch

class FoursquarePuller {
    static let instance = FoursquarePuller()
    var session: Session?

    init() {
        let client = Client(
            clientID: "KUFNI4DWRDT0RKT0AV3SEWSRGH2XCVK0TFQBZWMCTLZPPUVC",
            clientSecret: "R0RDPHSNVPWHSPM0OQ13XY10R5VT44Z0K1J0VYQYJAN1JUEQ",
            redirectURL: ""
        )
        
        let configuration = Configuration(client: client)
        Session.setupSharedSessionWithConfiguration(configuration)
        
        self.session = Session.sharedSession()
    }
    
    
    func getAndAddToMap(location: CLLocation, categoryId: String, map: MKMapView?) {
        guard let session = self.session else {
            return
        }
        
        var parameters = LocationParameters.details(location)
        parameters += [Parameter.categoryId: categoryId]
        parameters += [Parameter.radius: DistanceGlobals.maxSearch.description]
        parameters += [Parameter.limit: FoursquareGlobals.maxReturn.description]
        
        let venueDictionary:NSMutableDictionary = [:]

        let searchTask = session.venues.search(parameters) {
            (result) -> Void in
            guard let response = result.response else {
                return
            }
            
            guard let venues = response["venues"] as? [[String: AnyObject]] else {
                return
            }
            
            for venue:[String: AnyObject] in venues {
                guard let id = venue["id"] as? String else {
                    return
                }
                
                guard let name = venue["name"] as? String else {
                    return
                }
                
                guard let location = venue["location"] as? [String: AnyObject] else {
                    return
                }
                
                guard let latitude = location["lat"] as? Double else {
                    return
                }
                
                guard let longitude = location["lng"] as? Double else {
                    return
                }
                
                let venueObject = VenueObject(id: id, name: name, lat: latitude, lng: longitude)
                map?.addAnnotation(
                    Annotation(
                        title: venueObject.name, coordinate: CLLocationCoordinate2D(latitude: venueObject.lat, longitude: venueObject.lng)
                    )
                )
            }
        }
        searchTask.start()
    }
}