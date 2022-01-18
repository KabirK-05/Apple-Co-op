//
//  EndQualiViewController.swift
//  Formula Cycle
//
//  Created by Kabir Kumar on 2021-12-25.
//

import UIKit
import MapKit
import CoreLocation

class EndQualiViewController: UIViewController {

    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var topSpeed: UILabel!
    @IBOutlet weak var averageSpeedLbl: UILabel!
    @IBOutlet weak var maxRPM: UILabel!
    @IBOutlet weak var averageRPM: UILabel!
    @IBOutlet weak var powerWeight: UILabel!
    @IBOutlet weak var functionalThresholdPower: UILabel!
    
    @IBOutlet weak var sector1: UILabel!
    @IBOutlet weak var sector2: UILabel!
    @IBOutlet weak var sector3: UILabel!
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    var routeOverlay : MKOverlay?
    
    private var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        displayMetrics()
    }
    
    private func setUp() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.center = view.center
        
        determineCurrentLocation()
    
    }
    
    private func determineCurrentLocation() {
    if CLLocationManager.locationServicesEnabled() {
        locationManager.startUpdatingLocation()
    }
    }
    
    //TODO: Better format text (make units font size smaller than number)
    func displayMetrics() {
        elapsedTime.text = "\(totalTimeElapsed())"
        totalDistanceLbl.text = "\(totalDistance()) KM"
        topSpeed.text = "\(determineTopSpeed()) KM/H"
        averageSpeedLbl.text = "\(convertUnits(unit: "Km/h", speed: averageSpeed)) KM/H"
        
        let labelColours = sectorColour(numberOfSectors: 3)
        sector1.backgroundColor = labelColours[0]
        sector2.backgroundColor = labelColours[1]
        sector3.backgroundColor = labelColours[2]
    }
    
}


extension EndQualiViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
            // multi colour line
            let renderer = MKGradientPolylineRenderer(overlay: overlay)

            renderer.setColors(lineColours, locations: locationsAtPoint)

            renderer.lineCap = .round
            renderer.lineWidth = 5.0

            return renderer

    }
}

extension EndQualiViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    let userLocation:CLLocation = locations[0] as CLLocation
        
    
    let dynamicLine = MKPolyline(coordinates: locationPoints, count: locationPoints.count)
    
    setColour(polyline: dynamicLine)
        
    let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

    mapView.setRegion(region, animated: true)
    mapView.addOverlay(dynamicLine)
    locationManager.stopUpdatingLocation()
        
        
    }
    
}


