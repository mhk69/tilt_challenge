//
//  ViewController.swift
//  TiltChallenge
//
//  Created by Matt Klein on 1/14/16.
//  Copyright © 2016 MattKlein. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView?
    
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = CLLocationDistance(DistanceGlobals.distanceFilter)
        locationManager.startUpdatingLocation()
        
        guard let mapView = self.mapView else {
            return
        }
        
        mapView.delegate = self
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        guard let mapView = self.mapView else {
            return
        }
        let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, CLLocationDistance(DistanceGlobals.distanceForMap), CLLocationDistance(DistanceGlobals.distanceForMap))
        let center = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
        let centerRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        mapView.setRegion(region, animated: true)
        mapView.setRegion(centerRegion, animated: true)
        getPlaces(newLocation)
    }

    func getPlaces(location: CLLocation?) {
        if (location != nil) {
            self.lastLocation = location
        }
        
        guard let newLocation = self.lastLocation else {
            return
        }
        
        let _ = FoursquarePuller.instance.getAndAddToMap(newLocation, categoryId: FoursquareGlobals.cafeID, map: self.mapView)
    }
}

