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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Present map data of latest ride

    }

    

}
