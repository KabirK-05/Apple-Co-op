//
//  preparePolyline.swift
//  Formula Cycle
//
//  Created by Kabir Kumar on 2021-12-27.
//

import Foundation
import MapKit
import CoreLocation

// prepare points with coloured lines
func setColour(polyline: MKPolyline){
    for i in 0..<polyline.pointCount {
        
        let currentPoint = mapPoints[i]
        let relativeSpeed = CGFloat(currentPoint.speed/averageSpeed)
        relativeSpeeds.append(relativeSpeed)
        
        
    // set colours based on relative speed
        
        // dark red
        if relativeSpeed < 0.3{
            lineColours.append(UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        }
        
        // lighter red
        else if relativeSpeed < 0.5{
            lineColours.append(UIColor(red: 0.9, green: 0.15, blue: 0.0, alpha: 1.0))
        }
        // orange
        else if relativeSpeed < 0.7{
            lineColours.append(UIColor(red: 0.75, green: 0.25, blue: 0.0, alpha: 1.0))
        }
        
        // greenish orange
        else if relativeSpeed < 0.9{
            lineColours.append(UIColor(red: 0.55, green: 0.4, blue: 0.0, alpha: 1.0))
        }
        
        // green
        else if relativeSpeed < 1.25 {
            lineColours.append(UIColor(red: 0.25, green: 0.85, blue: 0.03, alpha: 1.0))
        }
        
        // purple
        else {
            lineColours.append(UIColor(red: 0.95, green: 0.05, blue: 1.0, alpha: 1.0))
        }
        
        let point = polyline.location(atPointIndex: i)
        locationsAtPoint.append(point)

    }
    
}



