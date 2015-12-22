//
//  GetGeoData.swift
//  SlideoutMenu
//
//  Created by Somesh Vyas on 04/11/15.
//  Copyright © 2015 Somesh Vyas. All rights reserved.
//

import UIKit
import CoreLocation

class GetGeoData: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var temp_user_id = String()
    var user_id = AnyObject?()
    var latitude = Double()
    var longitude = Double()
    var locality = NSString()
    var postalCode = NSString()
    var countrty = NSString()
    var counter = 0
    
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
        let location:CLLocation = (locations).last!
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) in
            if (error != nil) {print("reverse geodcode fail: \(error!.localizedDescription)")}
            if (placemarks!.count > 0){
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
            }
        })
    }
    func postUserGeoData(){
        if(counter == 0){
            /* Post data */
            let session = NSURLSession.sharedSession()
            let request = NSMutableURLRequest(URL: NSURL(string: "https://stark-shelf-4984.herokuapp.com/addGeoData")!)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPMethod = "POST"
            let data = "temp_user_id=\(temp_user_id)&user_id=&latitude=\(latitude)&longitude=\(longitude)&locality=\(locality)&postalCode=\(postalCode)&country=\(countrty)"
            request.HTTPBody = data.dataUsingEncoding(NSASCIIStringEncoding)
            let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
                if let error = error {
                    print(error)
                }
                if let data = data{
                    print("data =\(data)")
                }
                if let response = response {
                    print("url = \(response.URL!)")
                    print("response = \(response)")
                    let httpResponse = response as! NSHTTPURLResponse
                    print("response code = \(httpResponse.statusCode)")
                    
                    //if you response is json do the following
                    //                    do{
                    //                        let resultJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                    //                        let arrayJSON = resultJSON as! NSArray
                    //                        for value in arrayJSON{
                    //                            let dicValue = value as! NSDictionary
                    //                            for (key, value) in dicValue {
                    //                                print("key = \(key)")
                    //                                print("value = \(value)")
                    //                            }
                    //                        }
                    //
                    //                    }catch _{
                    //                        print("Received not-well-formatted JSON")
                    //                    }
                }
            })
            task.resume()
            counter++
        }
    }
    
    func updateUserGeoData(){
    
    }
    
    func displayLocationInfo(placemark: CLPlacemark)
    {
        self.locationManager.stopUpdatingLocation()
        locality = placemark.locality!
        postalCode = placemark.postalCode!
        countrty = placemark.country!
        user_id = NSUserDefaults.standardUserDefaults().valueForKey("userid")
        print("user id ")
        print(user_id)
        if(user_id == nil){
            print("sorry it is nil time to create temp user id. Get temp user id from temp rest api. 1234 has to be replaced from rest api")
            temp_user_id = "1234"
            NSUserDefaults.standardUserDefaults().setValue("1234", forKey: "temp_user_id")
            print("show login screen")
            self.postUserGeoData()
            self.performSegueWithIdentifier("geolocation", sender: placemark)
        } else {
            print("it is time to update geolocation of user")
            print("show directly kolada view")
            self.updateUserGeoData()
            self.performSegueWithIdentifier("showProfiles", sender: placemark)
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
}

