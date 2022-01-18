//
//  presentFinalData.swift
//  PitWall
//
//  Created by Kabir Kumar on 2022-01-03.
//

import Foundation
import CoreLocation
import UIKit


private func secondsToHoursMinutesSeconds(_ seconds: Int) -> String {
    let formattedTime = ("\(seconds/3600):\((seconds%3600) / 60):\((seconds % 3600)%60)")
    
    return formattedTime
}

func totalTimeElapsed() -> String {
    guard let date1 = (mapPoints.last?.timeStamp) else{return String()}
    let date2 = mapPoints[9].timeStamp
    
    
    let elapsedTime = Int(date1.timeIntervalSince(date2))
    print(elapsedTime)
    return secondsToHoursMinutesSeconds(elapsedTime)
}

func determineTopSpeed() -> Int {
    var topSpeed = Double()
    for i in 0...(mapPoints.count - 1){
        if mapPoints[i].speed > topSpeed{
            topSpeed = mapPoints[i].speed
        }
    }
    return convertUnits(unit: "Km/h", speed: topSpeed)
}

private func createSectors(numberOfSectors: Double) -> [Int] {
    // create 3 roughly equal sectors based on length
    let sectorLength = totalDistance()/numberOfSectors
    
    // save indexes of each sector length
    var sectorEndIndexes: [Int] = []
    var sectorDistance = Double()
    
    for i in 0...mapPoints.count-2{
        
        let loc1 = CLLocation(latitude: mapPoints[i].locationPoint.latitude, longitude: mapPoints[i].locationPoint.longitude)
        
        let loc2 = CLLocation(latitude: mapPoints[i+1].locationPoint.latitude, longitude: mapPoints[i+1].locationPoint.longitude)
        
        let distance = loc1.distance(from: loc2)
        sectorDistance += distance/1000.000
        
        
        //for the final sector
        if Int(numberOfSectors) - sectorEndIndexes.count == 1 {
            sectorEndIndexes.append(mapPoints.count-1)
        }
        
        if sectorDistance >= sectorLength && sectorEndIndexes.count < Int(numberOfSectors) {
            //Save index of sector
            //continue with next sector(s)
            sectorEndIndexes.append(i)
            sectorDistance = 0
        }
    }
    
    return sectorEndIndexes
}

private var combinedSpeed = Double()
private var divisor = Double()

private func sectorMetrics(numberOfSectors: Int) -> [Int]{
    // get average speed for each sector
    let sectorIndexes = createSectors(numberOfSectors: Double(numberOfSectors))
    var averageSpeeds: [Int] = []
    
    for i in 0...numberOfSectors-1 {
        var sectorStartIndex = Int()
        if i == 0{
            //start of mapPoints[]
            sectorStartIndex = 0
        }
        else {
            sectorStartIndex = sectorIndexes[i-1]+1
        }
        let sectorEndIndex = sectorIndexes[i]
        var averageSectorSpeed = Double()
        
        for eachPoint in sectorStartIndex...sectorEndIndex{
            // determine pace
            let currentSpeed = mapPoints[eachPoint].speed
            divisor += 1.00
            combinedSpeed += currentSpeed
            averageSectorSpeed = combinedSpeed/divisor
        }
        
        averageSpeeds.append(convertUnits(unit: "Km/h", speed: averageSectorSpeed))
        //reset currect sector stats and move to next
        divisor = 0
        combinedSpeed = 0
        averageSectorSpeed = 0
    }

    return averageSpeeds
}


func sectorColour(numberOfSectors: Int) -> [UIColor]{
    //determine sector label colour based on speed currently
    //TODO: Determine against elevation, RPM, FTP, PWR
    
    var sectorColours: [UIColor] = []
    let averageSpeeds = sectorMetrics(numberOfSectors: numberOfSectors)
    
    for i in 0...averageSpeeds.count-1{
        if Double(averageSpeeds[i]) > averageSpeed+2.5{
            //purple sector
            sectorColours.append(UIColor(red: 0.95, green: 0.05, blue: 1.0, alpha: 1.0))
        }
        
        if Double(averageSpeeds[i]) > averageSpeed-1.5{
            //green sector
            sectorColours.append(UIColor(red: 0.25, green: 0.85, blue: 0.03, alpha: 1.0))
        }
        else{
            //yellow sector
            sectorColours.append((UIColor(red: 0.85, green: 0.66, blue: 0.25, alpha: 1.0)))
        }
    }
    return sectorColours
}
