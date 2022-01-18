//
//  saveCoordinate.swift
//  Formula Cycle
//
//  Created by Kabir Kumar on 2021-11-25.
//

import Foundation
import MapKit

// ALL DATA CONTAINERS:

//Struct of
var mapPoints: [MapDataPoint] = []
var locationPoints: [CLLocationCoordinate2D] = []
//Location float values for polyline rendering:
var locationsAtPoint: [CGFloat] = []
var relativeSpeeds: [CGFloat] = []
var lineColours: [UIColor] = []
var averageSpeed = Double()
var RpmPoints: [RpmDataPoint] = []


struct MapDataPoint{
    var locationPoint = CLLocationCoordinate2D()
    var timeStamp = Date()
    var speed = Double()
}



func addPoint(latestLocation: CLLocation){
    let newMapPoint = MapDataPoint(locationPoint: latestLocation.coordinate, timeStamp: Date(), speed: latestLocation.speed)
    mapPoints.append(newMapPoint)
    locationPoints.append(newMapPoint.locationPoint)
}

var firstPoint: CLLocationCoordinate2D?
var lastPoint: CLLocationCoordinate2D?

func initializePoints() -> (firstPoint: CLLocationCoordinate2D?, lastPoint: CLLocationCoordinate2D?){
    let defaultVal = (CLLocationCoordinate2D(), CLLocationCoordinate2D())
    guard let initialLocation = mapPoints.first else {return defaultVal}
    firstPoint = initialLocation.locationPoint
    
    guard let finalLocation = mapPoints.last  else{return defaultVal}
    lastPoint = finalLocation.locationPoint
    
    return (firstPoint,lastPoint)
}



func getAdjacent(interval: Int) -> (pointOne: MapDataPoint, pointTwo: MapDataPoint){
    // return 2 latest adjacent points
    var mapPointOne = MapDataPoint()
    var mapPointTwo = MapDataPoint()
    
    if mapPoints.count >= interval{
        mapPointOne = mapPoints[mapPoints.count - 1]
        mapPointTwo = mapPoints[mapPoints.count - interval]
    }
    return (mapPointOne,mapPointTwo)
    
}
