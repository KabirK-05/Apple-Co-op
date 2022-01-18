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
    
    @IBOutlet weak var ridesTableView: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            configureLocationServices()
            //create x amount of data
            for _ in 0...20 {
                createData()
            }
        
        ridesTableView.delegate = self
        ridesTableView.dataSource = self
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


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ridesTableView.dequeueReusableCell(withIdentifier: "rideCell") as! PastRideTableViewCell
        
        
        let ride = sampleData[indexPath.row]
        
        cell.rideTypeLbl.text = ride.rideType
        cell.rideColourLbl.backgroundColor = ride.labelColour
        cell.totalDistLbl.text = String(ride.totalDistance)
        cell.avgSpeedLbl.text = String(ride.averageSpeed)
        
        return cell
    }
    
}
