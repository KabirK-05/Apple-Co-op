//
//  temporaryData.swift
//  PitWall
//
//  Created by Kabir Kumar on 2022-01-18.
//

import Foundation
import UIKit

var sampleData: [previousRideData] = []

struct previousRideData {
    var rideType: String
    var labelColour: UIColor
    var totalDistance: Double
    var averageSpeed: Double
}

let possibleLabelColours = [UIColor.systemTeal, UIColor.systemMint, UIColor.systemIndigo, UIColor.systemGray2, UIColor.magenta]

func createData() {
    let rideType = "Bike"
    let labelColour = possibleLabelColours[Int.random(in: 0..<5)]
    let totalDistance = Double.random(in: 4..<20.0).round(to: 1)
    let averageSpeed = Double.random(in: 9..<20.0).round(to: 1)
    
    let newRideData = previousRideData(rideType: rideType, labelColour: labelColour, totalDistance: totalDistance, averageSpeed: averageSpeed)
    
    sampleData.append(newRideData)
}
