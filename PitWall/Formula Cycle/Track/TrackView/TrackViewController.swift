//
//  TrackViewController.swift
//  Formula Cycle
//
//  Created by Kabir Kumar on 2021-11-25.
//

import UIKit
import MapKit
import CoreLocation

class TrackViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var typeOfRide: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var averageSpeedLbl: UILabel!
    @IBOutlet weak var totalTimeLbl: UILabel!
    
    @IBOutlet weak var qualiStart: UIButton!

    @IBOutlet weak var raceStart: UIButton!
    
    var routeOverlay : MKOverlay?
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        //TODO: Present map data of latest ride
        
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

extension TrackViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
            // multi colour line
            let renderer = MKGradientPolylineRenderer(overlay: overlay)

            renderer.setColors(lineColours, locations: locationsAtPoint)

            renderer.lineCap = .round
            renderer.lineWidth = 5.0

            return renderer

    }
}

extension TrackViewController: CLLocationManagerDelegate {
    
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
