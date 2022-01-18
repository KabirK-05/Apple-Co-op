//
//  QualiViewController.swift
//  Formula Cycle
//
//  Created by Kabir Kumar on 2021-11-24.
//

import UIKit
import MapKit

class QualiViewController: UIViewController{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var averageSpeedLbl: UILabel!
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    
    // Set to NOT record from initialization 
    var startStop = 1
    var startRecording = false
    
    @IBAction func startOutlap(_ sender: Any) {
        
        switch startStop{
            case 0:
                //stop recording
                startRecording = false
                startStop = 1
                
                // TODO: Fix label updating
                (sender as AnyObject).titleLabel?.font = UIFont(name: "Lao Sangam MN", size: 24)
                (sender as AnyObject).setTitle("Start Outlap", for: .normal)
                
            case 1:
                //start recording (again)
                startRecording = true
                startStop = 0
                (sender as AnyObject).setTitle("Stop Outlap", for: .normal)
            default:
                startRecording = false
                startStop = 0
        }
        
    }
    
    @IBAction func previewSegueBtn(_ sender: Any) {
        //stop recording and change startOutlap button text
        startRecording = false
        //TODO: Change text of startOutlap button
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
    
        // Do any additional setup after loading the view.
    }

    
    func configureLocationServices() {
        locationManager.delegate = self
        let status = locationManager.authorizationStatus

        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
           beginLocationUpdates(locationManager: locationManager)
        }
    }

    func beginLocationUpdates(locationManager: CLLocationManager) {
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    func startRecording(latestLocation: CLLocation, interval: Int){
        addPoint(latestLocation: latestLocation)
        
        // TODO: Use asset for start button
        
        // TODO: get user to select unit through UI
        let unit = "Km/h"
        
        // wait until GPS is accurate
        if mapPoints.count > 9{
            
            averageSpeed = pace()
            averageSpeedLbl.text = "\(convertUnits(unit: unit, speed: averageSpeed)) \(unit)"
            
            distanceLbl.text = "\(totalDistance()) KM"
            
            //storeMotion()
            //print(RpmPoints[RpmPoints.count - 1])
        }
        
        else {
            averageSpeedLbl.text = "-- \(unit)"
            distanceLbl.text = "-- KM"
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let latestLocation = locations.first else { return }

        zoomToLatestLocation(with: latestLocation.coordinate)
        currentCoordinate = latestLocation.coordinate
        
        //start saving/updating data
        if startRecording == true {
            startRecording(latestLocation: latestLocation, interval: 5)
        }
    }
    
}


extension QualiViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       print("The status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

