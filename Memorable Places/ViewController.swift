//
//  ViewController.swift
//  Memorable Places
//
//  Created by Lawrence Chen on 2/9/16.
//  Copyright © 2016 Lawrence Chen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!

    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization() // This only request the user whenever the location is being used
        manager.startUpdatingLocation()         // Constantly updates location of the user
        
        
        // Created variable equal to LongPressGestureRecognizer - action/ action function
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        
        // Long press duration is 2 seconds
        uilpgr.minimumPressDuration = 2.0
        
        // Added to map
        map.addGestureRecognizer(uilpgr)
        
    }
    
    
    func action(gestureRecognizer:UIGestureRecognizer){
    
        // Just to test the beginning of the long press - to recognize it
        // Code within will only be done once per long press
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
            
            // Getting the location of where they pressed
            var touchPoint = gestureRecognizer.locationInView(self.map)
            
            // Convert the touchPoint into coordinates
            var newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            
            // To get the location of the pin that is placed down - by the long press gesture
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                // Initially the title of the pin is empty
                var title = ""
                
                if(error == nil) {
                    
                    if let p = placemarks?[0] {
                    
                    var subThoroughfare:String = ""
                    var thoroughfare:String = ""
            
                    if p.subThoroughfare != nil {
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    if p.thoroughfare != nil {
                        
                        thoroughfare = p.thoroughfare!
                        
                    }
                    
                    title = "\(subThoroughfare) \(thoroughfare)"
                
                }
                
            }
            
            if(title == ""){
                
                title = "Added \(NSDate())"
                
            }
            
                
            // Defining the dictionary - appends	
            places.append(["name":title, "lat":"\(newCoordinate.latitude)", "lon":"\(newCoordinate.longitude)"])
                
            var annotation = MKPointAnnotation()
            
            annotation.coordinate = newCoordinate
            
            annotation.title = title
            annotation.subtitle = "I found you!"
            
            self.map.addAnnotation(annotation)
            
            })
        
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        // List of things needed: userLocation at position 1 (0)
        // userlocation latitude - userlocation longitude
        // coordinate - put together by the latitude and longitude 2DMake
        // latDelta - degrees \ lonDelta - degrees
        // span - MKCoordinate span = Make with the deltas
        // region - MKCoordinateRegion = Make with the coordinate and span
        
        var userLocation:CLLocation = locations[0]
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        self.map.setRegion(region, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

