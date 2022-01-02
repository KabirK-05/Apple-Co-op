//
//  calculateCoordinates.swift
//  Formula Cycle
//
//  Created by Kabir Kumar on 2021-12-10.
//

import Foundation
import MapKit

func convertUnits(unit: String, speed: Double?) -> Int{
    var convertedSpeed: Double
    
    guard let safeSpeed = speed else {return Int()}
    
    if unit == "M/h"{
        convertedSpeed = safeSpeed*2.23694
    }
    else {
        //default to kmph
        convertedSpeed = safeSpeed*3.6
    }
    
    return Int(convertedSpeed)
}

var combinedSpeedValue = Double()

func pace() -> Double{
    // return average speed throughout ride
    var nullCounter = 0
    guard let latestSpeed = mapPoints.last?.speed else{return Double()}
    
    // do not count speed if user has stopped (stop sign, traffic light)
    if latestSpeed <= 1{
        combinedSpeedValue += 0
        nullCounter += 1
    }
    else{
        combinedSpeedValue += latestSpeed
    }
    return (combinedSpeedValue/Double((mapPoints.count - nullCounter)))
}

var totalDistanceTravelled = Double()

func totalDistance() -> Double{
    //TODO: ignore first few points for greater accuracy
    
    //take distance between 2 points
    let points = getAdjacent(interval: 2)
    
    let loc1 = CLLocation(latitude: points.pointOne.locationPoint.latitude, longitude: points.pointOne.locationPoint.longitude)
    
    let loc2 = CLLocation(latitude: points.pointTwo.locationPoint.latitude, longitude: points.pointTwo.locationPoint.longitude)
    
    let distance = loc1.distance(from: loc2)
    
    totalDistanceTravelled += (Double(distance)/Double(1000))

    
    return totalDistanceTravelled
    
}



func checkDistance() -> Double {
    
    let point1 = mapPoints[0]
    let point2 = mapPoints[mapPoints.count-1]

    let loc1 = CLLocation(latitude: point1.locationPoint.latitude, longitude: point1.locationPoint.longitude)
    
    let loc2 = CLLocation(latitude: point2.locationPoint.latitude, longitude: point2.locationPoint.longitude)
    
    let distance = loc1.distance(from: loc2)

    return distance
}
