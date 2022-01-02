//
//  RpmHandler.swift
//  Formula Cycle
//
//  Created by Kabir Kumar on 2021-12-23.
//

import Foundation
import CoreMotion

var motionManager = CMMotionManager()



struct RpmDataPoint{
    var xAccel = motionManager.accelerometerData?.acceleration.x
    var yAccel = motionManager.accelerometerData?.acceleration.y
    var zAccel = motionManager.accelerometerData?.acceleration.z
    
    var xGyro = motionManager.gyroData?.rotationRate.x
    var yGyro = motionManager.gyroData?.rotationRate.y
    var zGyro = motionManager.gyroData?.rotationRate.z
    
    var timeStamp = Float()
}

func millisecondDate() -> Float{
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "mmss.SSSS"
    
    let timeStamp = formatter.string(from: date)
    let floatTime = (timeStamp as NSString).floatValue
    
    return floatTime
}


func startAccelerometer() -> (xAccel: Double, yAccel: Double, zAccel: Double){
    motionManager.startAccelerometerUpdates()
    guard let accelData = motionManager.accelerometerData else {return (Double(), Double(), Double())}
    let x = accelData.acceleration.x
    let y = accelData.acceleration.y
    let z = accelData.acceleration.z
    
    return (x, y, z)
}

func startGyro() -> (xGyro: Double, yGyro: Double, zGyro: Double){
    motionManager.startGyroUpdates()
    guard let gyroData = motionManager.gyroData else {return (Double(), Double(), Double())}
    let x = gyroData.rotationRate.x
    let y = gyroData.rotationRate.y
    let z = gyroData.rotationRate.z
    
    return(x, y, z)
}


func storeMotion(){
    let newRpmDataPoint = RpmDataPoint(xAccel: startAccelerometer().xAccel, yAccel: startAccelerometer().yAccel, zAccel: startAccelerometer().zAccel, xGyro: startGyro().xGyro, yGyro: startGyro().yGyro, zGyro: startGyro().zGyro, timeStamp: millisecondDate())
    
    RpmPoints.append(newRpmDataPoint)
}

