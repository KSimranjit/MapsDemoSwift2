//
//  ViewController.swift
//  MapsDemo
//
//  Created by Simranjit Kaur on 24/02/2016.
//  Copyright © 2016 Simranjit Kaur. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // that will use gps
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
        //getting latitude and longitude from google maps
        
        
        //centre the map and zoom it in particular location
        //Sydney 33.8650° S, 151.2094°
        let latitude:CLLocationDegrees = -33.8650
        let longitude:CLLocationDegrees = 151.2094
        let region:MKCoordinateRegion = getRegion(latitude,longitude: longitude)
        
        map.setRegion(region, animated: true)
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Sydney"
        annotation.subtitle = "I love Sydney"
        
        map.addAnnotation(annotation)
        
        
        //long press on screen generate pin of this place
        
        let uiLongPress = UILongPressGestureRecognizer(target: self, action: "action:")
        uiLongPress.minimumPressDuration = 2
        
        map.addGestureRecognizer(uiLongPress)
        
    }
    
    func getRegion(latitude:CLLocationDegrees , longitude:CLLocationDegrees) -> MKCoordinateRegion
    {
        //difference of latitude/longitude from one side screen to other
        let latDelta : CLLocationDegrees = 0.01
        let longDelta : CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        return region
    }

    func action(gestureRecognizer : UIGestureRecognizer)
    {
        
        let touchPoint = gestureRecognizer.locationInView(self.map)
        
        let newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        let newAnnotation = MKPointAnnotation()
        
        newAnnotation.coordinate = newCoordinate
        
        newAnnotation.title = "New Place"
        newAnnotation.subtitle = "One day i wil go there"
        
        map.addAnnotation(newAnnotation)
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation : CLLocation = locations[0]
        
        let region : MKCoordinateRegion = getRegion(userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        self.map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

