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

    @IBOutlet weak var mapView: MKMapView!
    var routeOverlay : MKOverlay?
    
    var locationManager = CLLocationManager()
    var testcoords:[CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    func setUp() {
        
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
    
    func determineCurrentLocation() {
    if CLLocationManager.locationServicesEnabled() {
        locationManager.startUpdatingLocation()
    }
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


