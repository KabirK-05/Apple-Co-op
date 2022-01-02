//
//  ViewController.swift
//  Formula Cycle
//
//  Created by Kabir Kumar on 2021-11-10.
//

import UIKit
import MapKit

//TODO: Save data of previous rides and list as interactable tableView

class ViewController: UIViewController {
   
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            configureLocationServices()
            
            // Do any additional setup after loading the view, typically from a nib.
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
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
    
    }

    extension ViewController: CLLocationManagerDelegate {

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print("Did get latest location")

            guard let latestLocation = locations.first else { return }

            zoomToLatestLocation(with: latestLocation.coordinate)
            currentCoordinate = latestLocation.coordinate
            
            
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           print("The status changed")
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                beginLocationUpdates(locationManager: manager)
            }
        }
    }


