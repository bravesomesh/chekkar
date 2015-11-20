//
//  ViewController.swift
//  SlideoutMenu
//
//  Created by Somesh Vyas on 04/11/15.
//  Copyright © 2015 Somesh Vyas. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAddViewController(placemark:CLPlacemark){
        self.performSegueWithIdentifier("geolocation", sender: placemark)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let longitude :CLLocationDegrees = -122.0312186
        let latitude :CLLocationDegrees = 37.33233141
        
        let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!

        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) in
            if (error != nil) {print("reverse geodcode fail: \(error!.localizedDescription)")}
            if (placemarks!.count > 0){
                //print(placemarks)
                let pm = placemarks![0] 
                self.displayLocationInfo(pm)
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark)
    {
        self.locationManager.stopUpdatingLocation()
        print(placemark.locality)
        print(placemark.postalCode)
        print(placemark.country)
        self.performSegueWithIdentifier("geolocation", sender: placemark)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
}

