//
//  ViewController.swift
//  soulmate
//
//  Created by Richard Hsu on 8/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var startLocation: CLLocation?
    
    //var userMapLocation: CLLocation?
    
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // start network request to alchemyapi
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: "https://access.alchemyapi.com/calls/data/GetNews?apikey=0c946bde49878224025230853ec995cc1693dc3e&return=enriched.url.title,enriched.url.url&start=1473897600&end=1474585200&q.enriched.url.cleanedTitle=charlotte&q.enriched.url.enrichedTitle.docSentiment.type=negative&q.enriched.url.enrichedTitle.taxonomy.taxonomy_.label=society&count=25&outputMode=json")
        
        let task = session.dataTaskWithURL(url!)
        {
            (data, response, error) -> Void in //in
            //guard let data = data else { print(error); return }
        
        
            //let result = NSString(data: data, encoding: NSUTF8StringEncoding)
            //print(result);
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200)
            {
                print("Request data is successful!")
                
                do
                {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    print(json)
                    
                }
                catch
                {
                    print("Error with JSON!")
                }
            }
         
            
            
            
        }
        task.resume();
       
        
        let userLocation = UserLocation(name: "You", type: "You are here!", imageName: "yourLocation.png", latitude: 38.9075, longitude: -77.0365)
        //mapView.setRegion(region, animated: true)
        
        
        mapView.delegate = self
        mapView.mapType = .Standard
        mapView.rotateEnabled = false
        //mapView.addAnnotation(userLocation)
        
        let regionRadius: CLLocationDistance = 15000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((userLocation.location.coordinate), regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // set up the locationManager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: MKMapViewDelegate
{
    func mapViewWillStartRenderingMap(mapView: MKMapView)
    {
        print("rendering")
    }
}

// implement the CLLocationManagerDelegate protocol 
extension ViewController: CLLocationManagerDelegate
{
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil
        {
            startLocation = locations.first
            print("---startLocation---")
            //print(startLocation)
            
            print(startLocation?.coordinate.latitude)
            print(startLocation?.coordinate.longitude)
            let userLocation = UserLocation(name: "You", type: "You are here!", imageName: "yourLocation.png", latitude: (startLocation?.coordinate.latitude)!, longitude: (startLocation?.coordinate.longitude)!)
            self.mapView.addAnnotation(userLocation)
            print("---")
        }
        else
        {
            guard let latest = locations.first else { return }
            let distanceInMeters = startLocation?.distanceFromLocation(latest)
            print("distance in meters: \(distanceInMeters!)")
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedWhenInUse || status == .AuthorizedAlways
        {
            //locationManager?.startUpdatingLocation()
            //locationManager?.allowsBackgroundLocationUpdates = true
            
            //locationManager?.requestLocation();
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    
    }
}




